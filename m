From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 7 Oct 2009 22:23:42 +0800
Subject: Kernel update to 2.6.31.1 on pxa270: udev and usb storage cause
	kernel Oops
In-Reply-To: <1254915955.26123.7.camel@wks02-lin.nanotronic.local>
References: <1254213562.5586.13.camel@wks02-lin.nanotronic.local>
	<20091003124832.GA15525@n2100.arm.linux.org.uk>
	<20091005225222.GB792@kroah.com>
	<1254915955.26123.7.camel@wks02-lin.nanotronic.local>
Message-ID: <f17812d70910070723u687e1244u7d8b9d4da816c68e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 7, 2009 at 7:45 PM, hoefle marco <marco.hoefle@nanotronic.ch> wrote:
> On Mon, 2009-10-05 at 15:52 -0700, Greg KH wrote:
>> On Sat, Oct 03, 2009 at 01:48:32PM +0100, Russell King - ARM Linux wrote:
>> > I think you need to report this to the USB/udev people.
>> >
>> > On Tue, Sep 29, 2009 at 10:39:22AM +0200, hoefle marco wrote:
>> > > Hello,
>> > > we use Kernel 2.6.30.4 on a PXA270 platform (from Phytec). It works good
>> > > with all peripherals on the Phytec board.
>> > > For an old Sandisk device (diskonchip) we have a driver ported to 2.6.3x
>> > > as the block device driver API has changed. We thought it will be a wise
>> > > decision to do the porting already to 2.6.3x.
>> > > However, when using the latest Kernel (and the previous one 2.6.30) with
>> > > all the drivers we used in 2.6.30.4 udev and usb storage seem not to
>> > > work any more.
>> > > Does anybody have an idea why?
>
> It looks that more things which worked with 2.6.30.4 do not work with
> the latest stable 2.6.31.2 kernel. I get also a Kernel oops when
> rebooting the system.
>
