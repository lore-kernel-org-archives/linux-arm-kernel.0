From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 17 Jan 2011 14:07:34 +0000
Subject: [PATCH] ASoC: EP93xx: fixed LRCLK rate and DMA oper. in I2S code
In-Reply-To: <1295182085.15631.231.camel@r60e>
References: <1291809693.31916.2.camel@r60e>
	<20101208124637.GD16418@rakim.wolfsonmicro.main>
	<1295182085.15631.231.camel@r60e>
Message-ID: <20110117140734.GG21113@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 16, 2011 at 03:48:05PM +0300, Alexander wrote:
> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> Changelog:
> 1. I2S module of EP93xx should be feed by 32bit DMA transfers. This is 
> hardware limitation and that's the way original Cirrus's driver worked.

Applied, thanks.
