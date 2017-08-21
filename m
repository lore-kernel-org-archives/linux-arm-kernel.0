From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 21 Aug 2017 08:31:24 +0000
Subject: [PATCH  2/3] ARM: dts: iwg20m: Enable SDHI0 controller
In-Reply-To: <20170821082842.GB2418@katana>
References: <1502711389-16040-1-git-send-email-biju.das@bp.renesas.com>
 <1502711389-16040-3-git-send-email-biju.das@bp.renesas.com>
 <20170821082842.GB2418@katana>
Message-ID: <KL1PR06MB1702AC0B4C40F48A80505B74B8870@KL1PR06MB1702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Wolfram Sang [mailto:wsa at the-dreams.de]
> Sent: 21 August 2017 09:29
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Simon Horman <horms@verge.net.au>; Magnus
> Damm <magnus.damm@gmail.com>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Wolfram Sang <wsa+renesas@sang-
> engineering.com>; devicetree at vger.kernel.org; linux-renesas-
> soc at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 2/3] ARM: dts: iwg20m: Enable SDHI0 controller
>
> > +
> > +&sdhi0 {
> > +pinctrl-0 = <&sdhi0_pins>;
> > +pinctrl-names = "default";
> > +
> > +vmmc-supply = <&reg_3p3v>;
> > +vqmmc-supply = <&reg_3p3v>;
> > +cd-gpios = <&gpio7 11 GPIO_ACTIVE_LOW>;
> > +status = "okay";
> > +};
>
> Just to make sure: No 1.8V and UHS support (SDR50/104)? Or is this to be
> tested and added later?

Thanks. The current hardware doesn't support 1.8V switching for SDHI0. There is a plan to
add this in future board varient, at that time we will add UHS support.







Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
