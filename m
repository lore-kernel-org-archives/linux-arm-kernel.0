From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 26 May 2011 20:43:34 -0500
Subject: [PATCH 3/5] ASoC: ep93xx: convert to use the DMA engine API
In-Reply-To: <9f8dd1eb40a6cb44d8207c84f244345a98bb9c0f.1306082097.git.mika.westerberg@iki.fi>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<9f8dd1eb40a6cb44d8207c84f244345a98bb9c0f.1306082097.git.mika.westerberg@iki.fi>
Message-ID: <0D753D10438DA54287A00B027084269764D331A4B5@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, May 22, 2011 10:03 AM, Mika Westerberg wrote:
>
> Now that we have the EP93xx DMA engine driver in place, we convert the ASoC
> drivers (I2S, AC97 and PCM) to take advantage of this new API. There are no
> functional changes.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
