From: timur@freescale.com (Timur Tabi)
Date: Mon, 5 Mar 2012 10:58:54 -0600
Subject: [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine driver
In-Reply-To: <20120305131332.GM3224@opensource.wolfsonmicro.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
 <20120304133818.GE3083@opensource.wolfsonmicro.com>
 <20120305080623.GD16232@S2101-09.ap.freescale.net>
 <20120305115612.GB3224@opensource.wolfsonmicro.com>
 <20120305130707.GF16232@S2101-09.ap.freescale.net>
 <20120305131332.GM3224@opensource.wolfsonmicro.com>
Message-ID: <4F54F0CE.60706@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> The DMA and SSI drivers should have some relationship with each other if
> they're the same piece of hardware.  

The DMA and SSI are completely separate blocks in the SOC.  On PowerPC,
the P1022 SOC has an SSI and the standard FSL PPC DMA controller (we call
it the Elo controller).  On i.MX, there is a completely different DMA
controller (I'm not familiar with it), but the same exact SSI.

-- 
Timur Tabi
Linux kernel developer at Freescale
