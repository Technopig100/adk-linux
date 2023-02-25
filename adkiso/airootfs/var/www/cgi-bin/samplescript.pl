#!/usr/bin/perl
#
# This is a sample script that shows how to use the Net::DBus bindings to
# connect to a bus and interact with existing methods and catch signals.
#
# Author: Madison Kelly (mkelly@alteeve.com).
#
 
use strict;
use warnings;
use utf8;
use Net::DBus;
use Net::DBus::Reactor;
 
print "Starting the client.\n";
 
# Connect to the system bus.
my $bus = Net::DBus->system;
 
# Connect to the 'Hal' service on the system bus.
my $hal=$bus->get_service("org.freedesktop.Hal");
 
# Connect to the interface '/org/freedesktop/Hal/Manager' and create a handle
# to the remote method 'org.freedesktop.Hal.Manager'. This is *sort* of like
# creating a handle to a normal perl module where you would say something like
# 'my $hal_manager=Some::Module->new();".
my $hal_manager = $hal->get_object("/org/freedesktop/Hal/Manager", "org.freedesktop.Hal.Manager");
 
# This calls a special method that asks HAL to list all the devices it already
# knows about. In a real world example, I would process these devices and
# update their status in a database. For now though, we will just print a line
# to the screen. Continuing the above analogy, this would now be like calling
# 'my @devices=$hal_manager->GetAllDevices(); foreach my $dev...' if this had
# been a normal perl module.
foreach my $dev (@{$hal_manager->GetAllDevices})
{
	if ( $dev =~ /^\/org\/freedesktop\/Hal\/devices\/volume_/ )
	{
		# For this example, I am looking for devices that start with
		# 'volume_*', as I know these to be storage devices. You can
		# change this to match whatever you are interested in.
		print "Adding a listener for the pre-existing device: [$dev]\n";
		&add_listener($hal, $dev);
	}
}
 
# Now I will add a handler that will react to signals with the name
# 'DeviceAdded', which I know is what HAL reports when a new device is added to
# the system.
$hal_manager->connect_to_signal('DeviceAdded', sub
{
	my ($callid) = @_;
	if ( $callid =~ /^\/org\/freedesktop\/Hal\/devices\/volume_/ )
	{
		# I saw that a device was added, and it matches my criteria for
		# what I am interested in, so I will add a listener for this
		# new device.
		print "Adding a listener for the newly connected device: [$callid]\n";
		&add_listener($hal, $callid);
	}
});
 
# And next I will add a second handler that will react to signals with the name
# 'DeviceRemoved', which I know is what HAL reports when a new device is
# removed from the system.
$hal_manager->connect_to_signal('DeviceRemoved', sub
{
	my ($callid) = @_;
	print "Device removed: [$callid]\n";
	# If I needed to, I could do cleanup here to see what has been removed.
	#&scan_devices();
});
 
# Lastly, now that my handlers are in place for the bus -> service -> object I
# am interested, I will connect to the main event loop using the Reactor
# module. This will do the dirty work of analyzing messages and triggering
# appropriate handlers as needed.
my $reactor = Net::DBus::Reactor->main();
$reactor->run();
 
# This is here mainly out of best practices. In the real world, this script
# will exit until it is sent an appropriate signal or is killed outright. For
# this reason, you will likely want to write out this process' PID to a file,
# generally somewhere in '/var/run' and add a system for catching signals and
# gracefully exiting.
print "Exiting the client.\n";
exit(0);
 
 
### Local Subroutines
 
# This adds a listener for a DBus object that Net::DBus::Reactor will report on.
sub add_listener
{
	my ($hal, $object)=@_;
	print "Adding a listener for object: [$object]\n";
 
	# Connect to the '$object' on the HAL device.
	my $hal_device = $hal->get_object("$object", "org.freedesktop.Hal.Device");
	$hal_device->connect_to_signal('PropertyModified', sub {
		my ($callid) = @_;
		# This could be any subroutine you want to call when the signal
		# 'PropertyModified' is emitted for this object. In a
		# real-world program, this could do a more extensive scan of
		# the device to see what all has changed.
		#&scan_devices();
	});
 
	return(0);
}
</font>