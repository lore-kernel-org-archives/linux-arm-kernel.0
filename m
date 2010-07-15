From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 15 Jul 2010 14:22:34 +0300
Subject: [PATCHv6] mx2_camera: Add soc_camera support for i.MX25/i.MX27
In-Reply-To: <40ccd21d0e857660038d193af3bb4cc6edd1067d.1278218817.git.baruch@tkos.co.il>
References: <40ccd21d0e857660038d193af3bb4cc6edd1067d.1278218817.git.baruch@tkos.co.il>
Message-ID: <20100715112234.GC7690@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jul 04, 2010 at 07:55:10AM +0300, Baruch Siach wrote:
> This is the soc_camera support developed by Sascha Hauer for the i.MX27.  Alan
> Carvalho de Assis modified the original driver to get it working on more recent
> kernels. I modified it further to add support for i.MX25. This driver has been
> tested on i.MX25 and i.MX27 based platforms.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---

Ping?

I'm currently working on a series of some small fixes and tweaks, but first I 
want to see the main code getting into mainline.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
