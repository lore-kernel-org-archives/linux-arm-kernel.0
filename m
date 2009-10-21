From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 21 Oct 2009 09:53:47 +0200
Subject: [PATCH RESEND#2] mmc: at91_mci: Don't include asm/mach/mmc.h
In-Reply-To: <1256111219-25266-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <4ADDF2E7.4010200@billgatliff.com>
	<1256111219-25266-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <4ADEBE0B.3060007@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig :
> This fixes a compile bug introduced in
> 
> 	6ef297f (ARM: 5720/1: Move MMCI header to amba include dir)
> 
> That commit moved arch/arm/include/asm/mach/mmc.h to
> include/linux/amba/mmci.h.  Just removing the include was enough.

FYI it is already in -mm patchsed as:
mmc-at91_mci-dont-include-asm-mach-mmch.patch

We now just have to track its way to mainline.

Bye,
-- 
Nicolas Ferre
