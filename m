From: contact@paulk.fr (Paul Kocialkowski)
Date: Thu, 24 Dec 2015 20:38:52 +0100
Subject: [PATCH 5/6] ARM: LG Optimus Black (P970) codename sniper
 support, with basic features
In-Reply-To: <CABxcv=moAUEPo8sq5KhuLZChrQtwjF1aBeNvV1i8HvUnwDXMZA@mail.gmail.com>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-6-git-send-email-contact@paulk.fr>
 <CABxcv=moAUEPo8sq5KhuLZChrQtwjF1aBeNvV1i8HvUnwDXMZA@mail.gmail.com>
Message-ID: <1450985932.11913.7.camel@collins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le mercredi 23 d?cembre 2015 ? 13:03 -0300, Javier Martinez Canillas a
?crit :
> Hello Paul,
> 
> [snip]
> 
> > +
> > +&omap3_pmx_core {
> > +       pinctrl-names = "default";
> > +
> > +       uart3_pins: pinmux_uart3_pins {
> > +               pinctrl-single,pins = <
> > +                       0x16e (PIN_INPUT | MUX_MODE0)           /* uart3_rx_irrx */
> > +                       0x170 (PIN_OUTPUT | MUX_MODE0)          /* uart3_tx_irtx */
> > +               >;
> 
> Could you please use the IOPAD mux macros from
> include/dt-bindings/pinctrl/omap.h instead?
> 
> We just did a massive cleanup on the OMAP DTS to use them instead of
> an offset from the padconf registers.

Sure thing, will do in v2.

Thanks for the review!

-- 
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151224/0b50f6ab/attachment.sig>
