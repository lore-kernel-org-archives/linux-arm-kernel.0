From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Jun 2013 10:38:50 +0200
Subject: [linux-sunxi] [PATCH 5/6] ARM: sunxi: Add Olimex
 A10s-Olinuxino-micro device tree
In-Reply-To: <51BB5C6D.5070308@elopez.com.ar>
References: <1370795767-9769-1-git-send-email-maxime.ripard@free-electrons.com>
 <1370795767-9769-6-git-send-email-maxime.ripard@free-electrons.com>
 <51BB5C6D.5070308@elopez.com.ar>
Message-ID: <20130617083850.GD16699@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Fri, Jun 14, 2013 at 03:09:49PM -0300, Emilio L?pez wrote:
> Hi Maxime,
> 
> El 09/06/13 13:36, Maxime Ripard escribi?:
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 75 ++++++++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> 
> Please add this on the sunxi target in arch/arm/boot/dts/Makefile so it
> gets built on make dtbs.
> 
> (snip)
> 
> > +	leds {
> > +		compatible = "gpio-leds";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&led_pins_olinuxino>;
> > +
> > +		power {
> > +			gpios = <&pio 4 3 0>;
> > +			default-state = "on";
> > +		};
> 
> Also, as discussed on IRC, I think it would be wise to change the name
> on the LED node. The schematics have a 'power' led already that is
> hard-wired to 3.3v, and this led node that you are declaring is referred
> as 'led1' there. I suppose 'green' would be a suitable name to keep
> consistency with other sunxi boards (namely cubieboard).
> 
> Other than that, my OLinuXino worked just fine after applying this
> patchset, so
> 
> Tested-by: Emilio L?pez <emilio@elopez.com.ar>

Thanks for your comments and the test.

I'll send a v2.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
