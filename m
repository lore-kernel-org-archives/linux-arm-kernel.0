From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Sep 2016 14:34:23 +0200
Subject: [PATCH v3 3/3] ARM: dts: gr8: Add support for the GR8 evaluation
 board
In-Reply-To: <CAGb2v648hLSKsCv6HjaYGUPtvMRGqFC5N-ST4Tp3qsNTw_igmQ@mail.gmail.com>
References: <20160908102610.26783-1-maxime.ripard@free-electrons.com>
 <20160908102610.26783-4-maxime.ripard@free-electrons.com>
 <CAGb2v648hLSKsCv6HjaYGUPtvMRGqFC5N-ST4Tp3qsNTw_igmQ@mail.gmail.com>
Message-ID: <20160908123423.GP8913@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 06:34:55PM +0800, Chen-Yu Tsai wrote:
> > +&i2c1 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&i2c1_pins_a>;
> > +       status = "okay";
> > +
> > +       pcf8563: rtc at 51 {
> > +               compatible = "phg,pcf8563";
> > +               reg = <0x51>;
> > +       };
> > +
> > +       wm8978: codec at 1a {
> 
> I think these should be ordered by address? Otherwise

Yeah, sorry, I don't know how to count anymore....

Thanks, I fixed it while applying.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/37cced38/attachment.sig>
