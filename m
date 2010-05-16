From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 16 May 2010 15:57:19 +0100
Subject: Patch 6127
Message-ID: <20100516145719.GB23961@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As I said on May 13th in the patch system:
> Note that this patch misses an 'unsigned long flags;' from at91_udc_irq().

To which there's been silence.  As I'm now freezing my tree so I can apply
other patches on top of this, I have no option but to drop this build-
breaking patch.

Please resubmit after the 2.6.35 merge window has happened (iow, once
2.6.35-rc1 has been released.)

Thanks.
