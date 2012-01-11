From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 11 Jan 2012 11:54:59 +0100
Subject: [PATCH v2 1/2] ARM: mxs: detect SoC by checking CHIPID register
In-Reply-To: <1325864366-17995-2-git-send-email-shawn.guo@linaro.org>
References: <1325864366-17995-1-git-send-email-shawn.guo@linaro.org>
 <1325864366-17995-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <201201111154.59344.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Both imx23 and imx28 have CHIPID register at address 0x8001c310, which
> can be used to identify the SoC.  This patch changes cpu_is_xxx and
> __arch_decomp_setup to use this CHIPID register than machine type to
> detect the chip between imx23 and imx28, so that we do not need to
> change these functions whenever a new board/machine gets added.
> 
> Suggested-by: Wolfram Sang <w.sang@pengutronix.de>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

Looks nice, please add my:

Acked-by: Marek Vasut <marek.vasut@gmail.com>

Also please keep me in Cc with mxs patches.

M
