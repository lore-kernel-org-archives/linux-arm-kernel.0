From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 02 Nov 2015 12:09:59 +0100
Subject: [RFC v2 1/2] Documentation: bridge: Add documentation for
 ps8640 DT properties
In-Reply-To: <1446436421.8671.1.camel@mszsdhlt06>
References: <1446430166-7378-1-git-send-email-jitao.shi@mediatek.com>
 <1446436421.8671.1.camel@mszsdhlt06>
Message-ID: <1446462599.3442.19.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jitao,

Am Montag, den 02.11.2015, 11:53 +0800 schrieb jitao shi:
[...]
> > +Example:
> > +	edp-bridge at 18 {
> > +		compatible = "parade,ps8640";
> > +		reg = <0x18>;
> > +		sleep-gpios = <&pio 116 GPIO_ACTIVE_HIGH>;
> > +		reset-gpios = <&pio 115 GPIO_ACTIVE_HIGH>;
> > +		mode-sel-gpios = <&pio 92 GPIO_ACTIVE_HIGH>;
> > +		ps8640-1v2-supply = <&ps8640_fixed_1v2>;

This should be vdd12-supply now.

> > +		ps8640-3v3-supply = <&mt6397_vgp2_reg>;

Should be vdd33-supply now.

regards
Philipp
