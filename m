From: B04825@freescale.com (Tabi Timur-B04825)
Date: Fri, 16 Mar 2012 04:17:02 +0000
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <20120316041428.GA7772@S2101-09.ap.freescale.net>
References: <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315142702.GL3138@opensource.wolfsonmicro.com>
 <4F621C60.5090700@freescale.com>
 <20120316020111.GE6065@S2101-09.ap.freescale.net>
 <4F62A06C.5000304@freescale.com>
 <20120316022345.GA7632@S2101-09.ap.freescale.net>
 <4F62B729.2090902@freescale.com>
 <20120316035254.GF6065@S2101-09.ap.freescale.net>
 <4F62BCBE.7030806@freescale.com>
 <20120316041428.GA7772@S2101-09.ap.freescale.net>
Message-ID: <4F62BEBC.9040203@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> I need to program the DMA controller for audio.  But that's done through
> generic dmaengine API with audio specific parameters passed in.  That's
> pretty much what all snd_imx_pcm_hw_params (sound/soc/fsl/imx-pcm-dma.c)
> does there.

Interesting.  I'll have to check that out.

-- 
Timur Tabi
Linux kernel developer at Freescale
