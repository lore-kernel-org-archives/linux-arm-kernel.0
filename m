From: horms@verge.net.au (Simon Horman)
Date: Wed, 28 Mar 2018 10:26:40 +0200
Subject: [PATCH  12/12] ARM: multi_v7_defconfig: Enable r8a77470 SoC
In-Reply-To: <OSBPR01MB21032F67E2F7463BF4CEA875B8AC0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1522161443-54428-1-git-send-email-biju.das@bp.renesas.com>
 <1522161443-54428-13-git-send-email-biju.das@bp.renesas.com>
 <TY1PR01MB1770FC01BEB7430AE352F5D0C0AC0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <OSBPR01MB21032F67E2F7463BF4CEA875B8AC0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <20180328082640.py5bjsjg5dcm6c66@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 02:57:28PM +0000, Biju Das wrote:
> Hello Fabrizio,
> 
> Thanks for the feedback.
> 
> > > Subject: [PATCH 12/12] ARM: multi_v7_defconfig: Enable r8a77470 SoC
> > >
> > > Enable recently added r8a77470 (RZ/G1C) SoC.
> > >
> > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > > Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > ---
> > >  arch/arm/configs/multi_v7_defconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm/configs/multi_v7_defconfig
> > > b/arch/arm/configs/multi_v7_defconfig
> > > index c1e045a..3623900 100644
> > > --- a/arch/arm/configs/multi_v7_defconfig
> > > +++ b/arch/arm/configs/multi_v7_defconfig
> > > @@ -90,6 +90,7 @@ CONFIG_ARCH_R8A73A4=y
> > CONFIG_ARCH_R8A7740=y
> > > CONFIG_ARCH_R8A7743=y  CONFIG_ARCH_R8A7745=y
> > > +CONFIG_ARCH_R8A7747=y
> >
> > s/CONFIG_ARCH_R8A7747/CONFIG_ARCH_R8A77470/
> 
> Will send V2.

Thanks, when posting v2 please include all patches that have
not been accepted.
