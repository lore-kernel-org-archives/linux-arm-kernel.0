From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Wed, 20 Jan 2010 12:12:53 +0100
Subject: [PATCH] mx3fb: some debug and initialisation fixes.
In-Reply-To: <Pine.LNX.4.64.0912201744490.14323@axis700.grange>
References: <1261152262.3356.69.camel@climbing-alby>
	<Pine.LNX.4.64.0912201744490.14323@axis700.grange>
Message-ID: <1263985973.3083.28.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On dom, 2009-12-20 at 17:45 +0100, Guennadi Liakhovetski wrote:
> On Fri, 18 Dec 2009, Alberto Panizzo wrote:
> 
> > Fix the kernel oops when dev_dbg is called with mx3_fbi->txd == NULL
> > 
> > Fix the late initialisation of mx3fb->backlight_level.
> > If not, in the chain of function started by init_fb_chan(), in
> __blank() call 
> > sdc_set_brightness(mx3fb, mx3fb->backlight_level) that will shut
> down
> > the CONTRAST PWM output. 
> > 
> > 
> > Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
> 
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Thanks
> Guennadi 

Thanks Guennadi for Acking.
Forgive me, but I not understand well the correct path for pulling this 
patch to linus tree.
I thought that Sascha was the right maintainer so I cc-ed him. But
I am wrong right?

Please can you point me to the right mailing list or maintainer?

Thanks
Alberto!
