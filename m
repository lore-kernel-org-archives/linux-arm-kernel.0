From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 29 May 2015 14:58:29 +0200
Subject: [GIT PULL] ARM: mediatek: arm64 updates for v4.2
In-Reply-To: <4904430.YVNgRyyb6C@wuerfel>
References: <CABuKBeLhFR=94cF301wL7J8hJVTtyseoD7g45PLE6znQkPAFGQ@mail.gmail.com>
 <3721931.mFVmMX4Ftz@wuerfel> <4904430.YVNgRyyb6C@wuerfel>
Message-ID: <20150529125829.GE6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 02:07:40PM +0200, Arnd Bergmann wrote:
> On Friday 29 May 2015 14:04:32 Arnd Bergmann wrote:
> > On Wednesday 27 May 2015 17:14:08 Matthias Brugger wrote:
> > > - dts: fixup pinctrl mt8173
> > > - dts: mt8173-evb fix model name
> > > - dts: mt8173 fix identation
> > > - dts: mt8173 add clock controller
> > > - dts: mt8173 change uart clocks
> > > - dts: mt8173 add pmic wrapper
> > > 
> > 
> > Pulled into next/dt, thanks!
> > 
> 
> Dropped it again, after getting a build error:
> 
>   DTC     arch/arm64/boot/dts/mediatek/mt8173-evb.dtb
> In file included from ../arch/arm64/boot/dts/mediatek/mt8173-evb.dts:16:0:
> ../arch/arm64/boot/dts/mediatek/mt8173.dtsi:14:42: fatal error: dt-bindings/clock/mt8173-clk.h: No such file or directory
>  #include <dt-bindings/clock/mt8173-clk.h>
>                                           ^
> 
> Please fix and resubmit.

These come from the clk tree. My original suggestion was to pull in this
dts changes late after -rc1. Other possibility: Stephen, can you provide
a stable commit containing the Mediatek clk changes?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
