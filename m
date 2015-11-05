From: jitao.shi@mediatek.com (jitao shi)
Date: Thu, 5 Nov 2015 09:15:18 +0800
Subject: [RFC v2 1/2] Documentation: bridge: Add documentation for
 ps8640 DT properties
In-Reply-To: <1446462599.3442.19.camel@pengutronix.de>
References: <1446430166-7378-1-git-send-email-jitao.shi@mediatek.com>
 <1446436421.8671.1.camel@mszsdhlt06>
 <1446462599.3442.19.camel@pengutronix.de>
Message-ID: <1446686118.8671.4.camel@mszsdhlt06>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-11-02 at 12:09 +0100, Philipp Zabel wrote:
> Hi Jitao,
> 
> Am Montag, den 02.11.2015, 11:53 +0800 schrieb jitao shi:
> [...]
> > > +Example:
> > > +	edp-bridge at 18 {
> > > +		compatible = "parade,ps8640";
> > > +		reg = <0x18>;
> > > +		sleep-gpios = <&pio 116 GPIO_ACTIVE_HIGH>;
> > > +		reset-gpios = <&pio 115 GPIO_ACTIVE_HIGH>;
> > > +		mode-sel-gpios = <&pio 92 GPIO_ACTIVE_HIGH>;
> > > +		ps8640-1v2-supply = <&ps8640_fixed_1v2>;
> 
> This should be vdd12-supply now.

Thanks a lot.  I'll fix it on V3.

> 
> > > +		ps8640-3v3-supply = <&mt6397_vgp2_reg>;
> 
> Should be vdd33-supply now.

I'll fix it on V3.

> 
> regards
> Philipp
> 
