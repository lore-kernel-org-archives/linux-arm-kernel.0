From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Jun 2013 23:45:06 +0200
Subject: [PATCH 10/10] arm: add basic support for Rockchip RK3066a boards
In-Reply-To: <20130605091119.18432af4@skate>
References: <201306030055.15413.heiko@sntech.de>
 <201306030102.20890.heiko@sntech.de>
 <20130605091119.18432af4@skate>
Message-ID: <20130605214506.GC14209@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Wed, Jun 05, 2013 at 09:11:19AM +0200, Thomas Petazzoni wrote:
> Dear Heiko St?bner,
> 
> On Mon, 3 Jun 2013 01:02:20 +0200, Heiko St?bner wrote:
> > index 0000000..a2d8c70
> > --- /dev/null
> > +++ b/arch/arm/mach-rockchip/Makefile.boot
> > @@ -0,0 +1,3 @@
> > +zreladdr-$(CONFIG_ARCH_ROCKCHIP)	:= 0x60408000
> > +params_phys-$(CONFIG_ARCH_ROCKCHIP)	:= 0x60088000
> > +initrd_phys-$(CONFIG_ARCH_ROCKCHIP)	:= 0x60800000
> 
> Thanks to the AUTO_ZRELADDR thing that you're using as part of the
> MULTIPLATFORM support, this Makefile.boot file is no longer useful. See
> mach-socfpga, mach-mvebu, mach-bcm2835, mach-bcm, mach-highbank, etc.
> 
> Cc'ing Maxime Ripard, since I see that mach-sunxi does have a
> Makefile.boot, even though I believe it is not needed.

Yes, it is a left-over and should be removed obviously.

Thanks for reminding it to me :)

Maxime
