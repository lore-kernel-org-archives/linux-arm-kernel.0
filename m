From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Jul 2013 21:40:13 +0800
Subject: [PATCH v2] ARM: dts: mxs: Add spi alias
In-Reply-To: <1374526621-29874-1-git-send-email-festevam@gmail.com>
References: <1374526621-29874-1-git-send-email-festevam@gmail.com>
Message-ID: <20130723134012.GB17327@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 22, 2013 at 05:57:01PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> After providing spi alias, we can get the following message during probe:
> 
> m25p80 spi1.0: sst25vf016b (2048 Kbytes)
> 
> ,which looks better than the original one:
> 
> m25p80 spi32766.0: sst25vf016b (2048 Kbytes)
> 
> While at it, keep the alias entries in alphabetical order.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
