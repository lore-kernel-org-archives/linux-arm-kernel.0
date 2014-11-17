From: c.hemp@phytec.de (Christian Hemp)
Date: Mon, 17 Nov 2014 09:27:37 +0100
Subject: [PATCH 2/5] ARM:dts:imx6:phyFLEX: Enable gpmi in module file
In-Reply-To: <1445555.ZBLGLeHvnl@wuerfel>
References: <1415971946-48975-1-git-send-email-c.hemp@phytec.de>
 <1415971946-48975-3-git-send-email-c.hemp@phytec.de>
 <1445555.ZBLGLeHvnl@wuerfel>
Message-ID: <3652599.ahZEGyuIxZ@lws-hemp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

Am Freitag, 14. November 2014, 15:55:11 schrieb Arnd Bergmann:
> On Friday 14 November 2014 14:32:23 Christian Hemp wrote:
> > --- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> > @@ -91,7 +91,7 @@
> > 
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&pinctrl_gpmi_nand>;
> >         nand-on-flash-bbt;
> > 
> > -       status = "disabled";
> > +       status = "okay";
> > 
> >  };
> 
> No need for the property unless you are overriding a 'status="disabled"'
> from another file. Just remove this property here.

the status is disabled in 'arch/arm/boot/dts/imx6qdl.dtsi'. 
That why I enabled it in the 'arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi'.

	Christian

> 
> 	Arnd
