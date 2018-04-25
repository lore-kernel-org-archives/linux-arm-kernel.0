From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 25 Apr 2018 16:12:25 +0000
Subject: [PATCH/RFC] ARM: shmobile: defconfig: Enable LPAE
In-Reply-To: <TYAPR01MB22857E6D2C5C38075841DAA5B78F0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <1524671610-13908-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TYAPR01MB22857E6D2C5C38075841DAA5B78F0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <TY1PR01MB1770174A08B37248E1CBFED3C08F0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Chris,

> Subject: RE: [PATCH/RFC] ARM: shmobile: defconfig: Enable LPAE
>
> Hello Fab,
>
> > From: Fabrizio Castro [mailto:fabrizio.castro at bp.renesas.com]
> > Sent: 25 April 2018 16:54
> >
> > On iWave's iwg20d DDR1 512MB memory cannot be accessed with 32-bit
> s/iwg20d/iwg20m

You are right, thank you for spotting this!
I'll send a v2 to fix this.

Cheers,
Fab

>
> Regards, Chris
>
> > addresses, hence we need LPAE.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > ---
> > This information is mentioned in the "RZ/G Series User?s Manual: Hardware",
> > Chapter 2, Area Map. Is this patch going to break the functionality of other
> > boards? Comments welcome.
> >
> >  arch/arm/configs/shmobile_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/configs/shmobile_defconfig
> > b/arch/arm/configs/shmobile_defconfig
> > index dd95d39..21b25e9 100644
> > --- a/arch/arm/configs/shmobile_defconfig
> > +++ b/arch/arm/configs/shmobile_defconfig
> > @@ -23,6 +23,7 @@ CONFIG_ARCH_R8A7792=y
> >  CONFIG_ARCH_R8A7793=y
> >  CONFIG_ARCH_R8A7794=y
> >  CONFIG_ARCH_SH73A0=y
> > +CONFIG_ARM_LPAE=y
> >  CONFIG_PL310_ERRATA_588369=y
> >  CONFIG_ARM_ERRATA_754322=y
> >  CONFIG_PCI=y
> > --
> > 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
