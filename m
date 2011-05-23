From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 23 May 2011 13:11:09 +0800
Subject: [PATCH 3/5] ASoC: ep93xx: convert to use the DMA engine API
In-Reply-To: <9f8dd1eb40a6cb44d8207c84f244345a98bb9c0f.1306082097.git.mika.westerberg@iki.fi>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<9f8dd1eb40a6cb44d8207c84f244345a98bb9c0f.1306082097.git.mika.westerberg@iki.fi>
Message-ID: <20110523051102.GA10683@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 22, 2011 at 08:03:06PM +0300, Mika Westerberg wrote:
> Now that we have the EP93xx DMA engine driver in place, we convert the ASoC
> drivers (I2S, AC97 and PCM) to take advantage of this new API. There are no
> functional changes.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Given that dmaengine is a standard API I'm wondering if we'll be able to
make some sort of generic dmaengine DMA driver for ASoC that could be
shared more widely.
