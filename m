From: marex@denx.de (Marek Vasut)
Date: Wed, 6 Mar 2013 17:41:59 +0100
Subject: [PATCH v3 09/12] ASoC: dmaengine_pcm: add
 snd_dmaengine_generic_pcm_open()
In-Reply-To: <20130306051131.GB1828@S2100-06.ap.freescale.net>
References: <1362486244-24593-10-git-send-email-shawn.guo@linaro.org>
 <201303060028.18625.marex@denx.de>
 <20130306051131.GB1828@S2100-06.ap.freescale.net>
Message-ID: <201303061741.59436.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Wed, Mar 06, 2013 at 12:28:18AM +0100, Marek Vasut wrote:
> > Hi Shawn,
> > 
> > > With generic DMA device tree binding and helper function
> > > dma_request_slave_channel() in place, dmaengine_pcm should support
> > > that in requesting DMA channel for users that support generic DMA
> > > device tree binding.
> > > 
> > > Add a new API snd_dmaengine_generic_pcm_open() as the variant of
> > > snd_dmaengine_pcm_open().  It takes DMA client struct device pointer
> > > and slave channel name as arguments and calls generic DMA helper
> > > dma_request_slave_channel() to request DMA channel from dmaengine.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > > Cc: alsa-devel at alsa-project.org
> > > ---
> > > 
> > > Changes since v2:
> > >  - Drop 'const' from argument 'name' to fix the warning below.
> > 
> > [...]
> > 
> > v3 changelog missing ;-) What did you adjust here please?
> 
> The "Changes since v2" means v3 changelog.

Bah, it was too late then, sorry.

Best regards,
Marek Vasut
