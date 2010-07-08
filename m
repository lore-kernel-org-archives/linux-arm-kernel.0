From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 8 Jul 2010 08:44:36 +0300
Subject: i.MX51 kernel trees: Where to start?
In-Reply-To: <201007071408.50621.david.jander@protonic.nl>
References: <201007071408.50621.david.jander@protonic.nl>
Message-ID: <20100708054436.GC25143@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Wed, Jul 07, 2010 at 02:08:50PM +0200, David Jander wrote:
> 1.- What's the most recommended (git-) tree to start from doing BSP 
> development?
> Right now, I am playing with sources downloaded from freescale directly, and 
> AFAICS this is quite similar to the "tracking-fsl-imx_2.6.31" branch from denx 
> git:
> 
> http://git.denx.de/?p=linux-2.6-denx.git;a=shortlog;h=refs/heads/tracking-fsl-
> imx_2.6.31
> 
> Is this indeed the best place to start?

If you want to go with the mainline kernel then the place where i.MX 
development is happening is 
http://git.pengutronix.de/?p=imx/linux-2.6.git;a=summary

> What other trees are there, and how can I get an impression of the state of 
> each one?  How far are effords for mainline inclusion of the freescale 
> patches?

Freescale are doing very little to push their work for mainline inclusion.  
Amit Kucheria from Canonical/Linaro has been doing some work on the i.MX5 
front. This work is in the mainline kernels since 2.6.34.

> 2.- Using this kernel, I notice the touchscreen driver, (mxc_ts.c) not 
> working correctly. It looks like it works for a few seconds after boot, and 
> then starts delaying samples very much, to the point that it is unusable. Is 
> this a known problem? Is there someone working on this? Should I use another 
> driver?

This driver is not in the mainline kernel, so the help you may get from kernel 
developers is limited. In any case, questions about the input subsystem should 
go to the linux-input mailing list (linux-input at vger.kernel.org).

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
