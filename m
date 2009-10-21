From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 21 Oct 2009 10:12:12 +0200
Subject: [PATCH RESEND#2] mmc: at91_mci: Don't include asm/mach/mmc.h
In-Reply-To: <4ADEBE0B.3060007@atmel.com>
References: <4ADDF2E7.4010200@billgatliff.com>
	<1256111219-25266-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<4ADEBE0B.3060007@atmel.com>
Message-ID: <20091021081212.GA9453@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2009 at 09:53:47AM +0200, Nicolas Ferre wrote:
> Uwe Kleine-K?nig :
> > This fixes a compile bug introduced in
> > 
> > 	6ef297f (ARM: 5720/1: Move MMCI header to amba include dir)
> > 
> > That commit moved arch/arm/include/asm/mach/mmc.h to
> > include/linux/amba/mmci.h.  Just removing the include was enough.
> 
> FYI it is already in -mm patchsed as:
> mmc-at91_mci-dont-include-asm-mach-mmch.patch
oh right.  I was pretty sure I didn't get a "patch was added to mm" mail
by Andrew, but searching my inbox proofed me wrong.

Sorry
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
