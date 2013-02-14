From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 14 Feb 2013 09:49:28 -0300
Subject: Build error: OMAP randconfig / mvebu
In-Reply-To: <201302141221.16267.arnd@arndb.de>
References: <20130208100813.GN17833@n2100.arm.linux.org.uk>
 <201302141127.07378.arnd@arndb.de>
 <20130214120650.GA11345@localhost>
 <201302141221.16267.arnd@arndb.de>
Message-ID: <20130214124927.GB11345@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Thu, Feb 14, 2013 at 12:21:16PM +0000, Arnd Bergmann wrote:
> On Thursday 14 February 2013, Ezequiel Garcia wrote:
> > Now, using the random config there's a new error, unrelated to the
> > previous one:
> > 
> > ERROR: "twl6030_interrupt_unmask" [drivers/usb/otg/twl6030-usb.ko] undefined!
> > ERROR: "twl_i2c_read_u8" [drivers/usb/otg/twl6030-usb.ko] undefined!
> > ERROR: "twl_i2c_write_u8" [drivers/usb/otg/twl6030-usb.ko] undefined!
> > ERROR: "twl6030_interrupt_mask" [drivers/usb/otg/twl6030-usb.ko] undefined!
> 
> Yes, I guess that is an unrelated error. However, my patch also wasn't
> correct because it is not allowed to have an empty list of objects.
> 
> There is an updated patch below, I could add that straight to the branch
> that caused the problem if it looks ok to you.

The compile error is fixed here with this patch also.

Thanks,

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
