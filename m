From: timur@tabi.org (Timur Tabi)
Date: Sun, 14 Apr 2013 09:53:57 -0500
Subject: [PATCH v2 05/11] ASoC: fsl-ssi: Add support for imx-pcm-fiq
In-Reply-To: <20130414141015.GC27394@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-6-git-send-email-mpa@pengutronix.de>
 <51620CEA.3010703@tabi.org> <20130414103819.GA27394@pengutronix.de>
 <516AB111.3000007@tabi.org> <20130414141015.GC27394@pengutronix.de>
Message-ID: <516AC305.2000800@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Markus Pargmann wrote:
> In general, imx27 does support SSI with DMA, for example
> MACH_IMX27_VISSTRIM_M10 does use SSI with DMA. But there are special
> boards like Eukrea TLV320 and phycore-ac97 that have to use FIQ instead.
> All of them have a imx27 chip.

Why is the decision to use FIQ board-specific?  All of the hardware is 
inside the SoC itself.  How could a board make using DMA impossible?

-- 
Timur Tabi
