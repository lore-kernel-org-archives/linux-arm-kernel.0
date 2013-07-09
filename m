From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Jul 2013 13:29:27 +0800
Subject: [PATCH 3/3] ARM:dts:vf610-twr:Enable DSPI0 devices and Flash
 at26df081a
In-Reply-To: <20130708113600.GU27646@sirena.org.uk>
References: <1373272622-29064-1-git-send-email-b44548@freescale.com>
 <1373272622-29064-3-git-send-email-b44548@freescale.com>
 <20130708113600.GU27646@sirena.org.uk>
Message-ID: <20130709052925.GD16656@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 12:36:01PM +0100, Mark Brown wrote:
> On Mon, Jul 08, 2013 at 04:37:02PM +0800, Chao Fu wrote:
> > From: Chao Fu <B44548@freescale.com>
> > 
> > This patch enables DSPI0 and at26df081a flash device for Vybrid VF610 TOWER board.
> 
> Acked-by: Mark Brown <broonie@linaro.org>
> 
> This should be fine to merge via arm-soc, it's no real dependency on the
> actual SPI driver.

It has dependency on the actual SPI driver where the DT bindings are
defined, so I would only take the patches after the driver parts gets
accepted.

Shawn
