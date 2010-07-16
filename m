From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 16 Jul 2010 09:02:57 +0200
Subject: [PATCHv6] mx2_camera: Add soc_camera support for i.MX25/i.MX27
In-Reply-To: <Pine.LNX.4.64.1007111315560.30182@axis700.grange>
References: <40ccd21d0e857660038d193af3bb4cc6edd1067d.1278218817.git.baruch@tkos.co.il>
	<Pine.LNX.4.64.1007111315560.30182@axis700.grange>
Message-ID: <20100716070257.GH14113@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 11, 2010 at 01:18:27PM +0200, Guennadi Liakhovetski wrote:
> On Sun, 4 Jul 2010, Baruch Siach wrote:
> 
> > This is the soc_camera support developed by Sascha Hauer for the i.MX27.  Alan
> > Carvalho de Assis modified the original driver to get it working on more recent
> > kernels. I modified it further to add support for i.MX25. This driver has been
> > tested on i.MX25 and i.MX27 based platforms.
> > 
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> So, who shall be taking this patch? I'd prefer it go via ARM. Then you can 
> easier satisfy any dependencies and enforce a certain patch order. It has 
> my ack, just verified v6 - my ack still holds (I hope, Baruch did 
> compile-test this new version on various i.MX2x versions). However, if you 
> prefer, I can also take it via soc-camera / v4l. Sascha, what's your take?

There won't be conflicts when this goes over v4l, but otoh if Baruch
plans to add board support till the next window the platform_data will
be missing and my tree won't compile. So it's probably best to push it
through the i.MX tree.

Will apply this afternoon if noone objects.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
