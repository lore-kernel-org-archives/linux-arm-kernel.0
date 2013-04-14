From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sun, 14 Apr 2013 14:13:15 +0200
Subject: [PATCH v3 00/15] ASoC: fsl-ssi: ac97-slave support
In-Reply-To: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
Message-ID: <516A9D5B.2070707@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2013 01:42 PM, Markus Pargmann wrote:
> Hi,
> 
> This series adds DT support for phycore-ac97. It is now based on the pcm dma
> cleanups from Lars. Beside ac97 support, the series adds fsl-ssi imx-pcm-fiq
> and generic DMA binding handling.
> 
> @Lars:
> There are 4 new patches at the beginning of the series that fix some problems
> of your cleanups. I think they were in the changes you posted. If not, could you
> please add them to your branch?

Hi,

I had already fixed them localy. I'm in the process of polishing the last bits
and pieces of my generic dmaengine PCM driver series right now and will submit
it later today.

- Lars
