From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Jan 2016 09:43:28 +0100
Subject: [linux-sunxi] [RFC PATCH] drivers: pinctrl: add driver for
 Allwinner A64 SoC
In-Reply-To: <CAEzqOZsE_kDChAbLkwmwjqdDbovv1e0G1tTffhhp25PkwJQ0+Q@mail.gmail.com>
References: <1451582246-32373-1-git-send-email-andre.przywara@arm.com>
 <CAEzqOZsE_kDChAbLkwmwjqdDbovv1e0G1tTffhhp25PkwJQ0+Q@mail.gmail.com>
Message-ID: <20160104084328.GB23528@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 04, 2016 at 02:34:52PM +0800, Vishnu Patekar wrote:
> > diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
> > index e080290..130e7bc 100644
> > --- a/drivers/pinctrl/sunxi/Makefile
> > +++ b/drivers/pinctrl/sunxi/Makefile
> > @@ -12,5 +12,6 @@ obj-$(CONFIG_PINCTRL_SUN7I_A20)               += pinctrl-sun7i-a20.o
> >  obj-$(CONFIG_PINCTRL_SUN8I_A23)                += pinctrl-sun8i-a23.o
> >  obj-$(CONFIG_PINCTRL_SUN8I_A23_R)      += pinctrl-sun8i-a23-r.o
> >  obj-$(CONFIG_PINCTRL_SUN8I_A33)                += pinctrl-sun8i-a33.o
> > +obj-$(CONFIG_PINCTRL_A64)              += pinctrl-a64.o
> 
> Shouldn't this follow pinctrl config name like other sunXi SOCs?
> This should be PINCTRL_SUN??_A64.
> 
> First, we should find family name for A64. I remember, on IRC Maxime
> refering A64 to family named sun10i.

It's called sun50i in the BSP, so I guess we can go with that.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/e3a356ed/attachment.sig>
