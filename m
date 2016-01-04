From: tony@atomide.com (Tony Lindgren)
Date: Mon, 4 Jan 2016 09:40:01 -0800
Subject: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
In-Reply-To: <201601041834.56056@pali>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <568662FC.9050206@gmail.com> <20160104170206.GC12777@atomide.com>
 <201601041834.56056@pali>
Message-ID: <20160104174001.GD12777@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [160104 09:35]:
> On Monday 04 January 2016 18:02:06 Tony Lindgren wrote:
> > Care to boot with CONFIG_OMAP_GPMC_DEBUG=y and post the gpmc related
> > dmesg output?
> 
> Hi Tony. We do not have serial console for N900 and so when kernel is 
> not fully bootable to userspace we cannot provide dmesg for you :-(

OK

> Maybe something with simple initramfs could work, but really if you have 
> serial console for N900 it should be for you lot of easier to get it.

Yeah OK will take a look ASAP. Is this happening with both legacy
booting and dts based booting?

For testing, CONFIG_INITRAMFS_SOURCE etc allow building initramfs
that's appended to the kernel.

Regards,

Tony
