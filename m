From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Mon, 23 May 2011 10:38:51 +0100
Subject: [PATCH 3/5] ASoC: ep93xx: convert to use the DMA engine API
In-Reply-To: <20110523051102.GA10683@opensource.wolfsonmicro.com>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<9f8dd1eb40a6cb44d8207c84f244345a98bb9c0f.1306082097.git.mika.westerberg@iki.fi>
	<20110523051102.GA10683@opensource.wolfsonmicro.com>
Message-ID: <1306143537.3290.0.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-23 at 13:11 +0800, Mark Brown wrote:
> On Sun, May 22, 2011 at 08:03:06PM +0300, Mika Westerberg wrote:
> > Now that we have the EP93xx DMA engine driver in place, we convert the ASoC
> > drivers (I2S, AC97 and PCM) to take advantage of this new API. There are no
> > functional changes.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Given that dmaengine is a standard API I'm wondering if we'll be able to
> make some sort of generic dmaengine DMA driver for ASoC that could be
> shared more widely.

Agreed and 

Acked-by: Liam Girdwood <lrg@ti.com>
