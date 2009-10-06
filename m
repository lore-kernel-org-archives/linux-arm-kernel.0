From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 6 Oct 2009 08:48:52 +0200
Subject: [PATCH v2] fix pcm037_eet compilation with the new SPI driver
In-Reply-To: <Pine.LNX.4.64.0910051644010.4337@axis700.grange>
References: <Pine.LNX.4.64.0910051001500.4337@axis700.grange>
	<20091005121936.GD23986@pengutronix.de> <4AC9FC2D.6000200@epfl.ch>
	<Pine.LNX.4.64.0910051644010.4337@axis700.grange>
Message-ID: <20091006064852.GH23986@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2009 at 04:49:12PM +0200, Guennadi Liakhovetski wrote:
> Fix pcm037_eet compilation with the new imx SPI driver by unifying 
> platform device names.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> On Mon, 5 Oct 2009, Valentin Longchamp wrote:
> 
> > Hi Sascha,
> > 
> > Sascha Hauer wrote:
> > > 
> > > On Mon, Oct 05, 2009 at 10:04:51AM +0200, Guennadi Liakhovetski wrote:
> > > > At some point the SPI device name in arch/arm/mach-mx3/devices.c has
> > > > changed, which then broke compilation of pcm037_eet with the new SPI
> > > > driver. Use the correct name.
> > > 
> > > It didn't change, it was merged with imx_spi_device0. Can we change the
> > > name in devices.[ch] instead? All other devices start with mxc_. Sorry,
> > > my bad.
> > 
> > I don't really where it is changed ... mxc seems better so devices.[ch] is
> > more logical.
> > 
> > But I have sent the exact same patch on Friday and received no comment ... I
> > hope mine or Guennadi's (I don't really care) can get its way to -rc4.
> 
> Sorry, I missed it. Here's a version with changed devices.[hc].

Ok, thanks.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
