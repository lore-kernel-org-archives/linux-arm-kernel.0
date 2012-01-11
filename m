From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 11 Jan 2012 21:07:24 +0800
Subject: [PATCH v2 1/2] ARM: mxs: detect SoC by checking CHIPID register
In-Reply-To: <201201111154.59344.marek.vasut@gmail.com>
References: <1325864366-17995-1-git-send-email-shawn.guo@linaro.org>
 <1325864366-17995-2-git-send-email-shawn.guo@linaro.org>
 <201201111154.59344.marek.vasut@gmail.com>
Message-ID: <20120111130721.GA20968@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 11:54:59AM +0100, Marek Vasut wrote:
> > Both imx23 and imx28 have CHIPID register at address 0x8001c310, which
> > can be used to identify the SoC.  This patch changes cpu_is_xxx and
> > __arch_decomp_setup to use this CHIPID register than machine type to
> > detect the chip between imx23 and imx28, so that we do not need to
> > change these functions whenever a new board/machine gets added.
> > 
> > Suggested-by: Wolfram Sang <w.sang@pengutronix.de>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> 
> Looks nice, please add my:
> 
> Acked-by: Marek Vasut <marek.vasut@gmail.com>
> 
Sorry, the patch has been sent to arm-soc.

> Also please keep me in Cc with mxs patches.
> 
Ok, will do.

-- 
Regards,
Shawn
