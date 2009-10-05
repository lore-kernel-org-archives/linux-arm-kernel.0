From: greg@kroah.com (Greg KH)
Date: Mon, 5 Oct 2009 15:52:22 -0700
Subject: Kernel update to 2.6.31.1 on pxa270: udev and usb storage
	cause kernel Oops
In-Reply-To: <20091003124832.GA15525@n2100.arm.linux.org.uk>
References: <1254213562.5586.13.camel@wks02-lin.nanotronic.local>
	<20091003124832.GA15525@n2100.arm.linux.org.uk>
Message-ID: <20091005225222.GB792@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 03, 2009 at 01:48:32PM +0100, Russell King - ARM Linux wrote:
> I think you need to report this to the USB/udev people.
> 
> On Tue, Sep 29, 2009 at 10:39:22AM +0200, hoefle marco wrote:
> > Hello,
> > we use Kernel 2.6.30.4 on a PXA270 platform (from Phytec). It works good
> > with all peripherals on the Phytec board. 
> > For an old Sandisk device (diskonchip) we have a driver ported to 2.6.3x
> > as the block device driver API has changed. We thought it will be a wise
> > decision to do the porting already to 2.6.3x. 
> > However, when using the latest Kernel (and the previous one 2.6.30) with
> > all the drivers we used in 2.6.30.4 udev and usb storage seem not to
> > work any more.
> > Does anybody have an idea why?

No, I don't. Do you have a pointer to your code anywhere?

thanks,

greg k-h
