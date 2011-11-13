From: tom.leiming@gmail.com (Ming Lei)
Date: Sun, 13 Nov 2011 19:04:51 +0800
Subject: [QUESTION] omap iommu: a generic IOMMU?
Message-ID: <CACVXFVPLgXfcpE9x2KKbU=r9_+ZeEbfo1TGndvm6yi34V15tPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi  guys,

I found that omap-iommu.c has been under drivers/iommu for some time.

Just be curious, is it a generic IOMMU so that it can be used by all IO
peripherals in OMAP4?  Could you give some use cases about
the omap-iommu in kernel?

>From related source code[1] and OMAP4 TRM[2], looks like the omap iommu
only belongs to Cortex-M3 MPU subsystem inside OMAP4 chip, so I am wondering
why introduces the driver for arm v7 based linux kernel...

[1], arch/arm/mach-omap2/omap-iommu.c
[2], "20.5 MMU Register Manual" of "omap4 TRM Version O"

thanks,
-- 
Ming Lei
