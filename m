From: alison.wang@freescale.com (Huan Wang)
Date: Fri, 28 Aug 2015 08:04:03 +0000
Subject: [PATCH v3] ARM: configs: Add Freescale LS1021A defconfig
In-Reply-To: <55D6073C.1020000@freescale.com>
References: <1438941784-38403-1-git-send-email-b18965@freescale.com>
 <55CB4829.40204@freescale.com> <55CE1FFE.2080200@freescale.com>
 <CAOMZO5By_15OCsb7z2pbywPi3n9vKGj=393hWYHVEQ32=jDNaA@mail.gmail.com>
 <BN3PR0301MB08672520CA978383BBF2CF6CFE790@BN3PR0301MB0867.namprd03.prod.outlook.com>
 <55D6073C.1020000@freescale.com>
Message-ID: <BN3PR0301MB0867591B07957C47F30C9711FE6E0@BN3PR0301MB0867.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Horia,

> On 8/17/2015 6:42 AM, Wang Huan-B18965 wrote:
> > Hi, Fabio,
> 
> Please don't top post.
> 
> >
> > 	Based on the analysis and discussion, we prefer to use
> ls1021a_defconfig and remove LS1021A from imx_v6_v7_defconfig.
> 
> Alison, when you submit v4 for this patch (adding
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y as suggested), could you also send a
> patch removing CONFIG_SOC_LS1021A from imx_v6_v7_config?
[Alison Wang] I don?t know CONFIG_ARCH_DMA_ADDR_T_64BIT=y is suggested.
Could you help to explain the suggestion?

I need Fabio's confirmation about removing CONFIG_SOC_LS1021A from imx_v6_v7_config.

Fabio, Do you agree it?
> 
> >
> > 	Thanks.
> >
> > Best Regards,
> > Alison Wang
> >
> >> On Fri, Aug 14, 2015 at 2:06 PM, Horia Geant?
> >> <horia.geanta@freescale.com> wrote:
> >>
> >>> Another thing:
> >>> Commit 385c0fb0e2c4 ("ARM: imx_v6_v7_defconfig: Select LS1021A")
> >> added
> >>> CONFIG_SOC_LS1021A in imx_v6_v7_defconfig.
> >>>
> >>> Besides this, booting a LS1021 AQDS board (Rev2) using
> >>> imx_v6_v7_defconfig did not work (stuck at "Starting kernel").
> >>
> >> What would be the recommended approach?
> >>
> >> - Fix imx_v6_v7_defconfig so that it can make LS1021A to boot
> >>
> >> or
> >>
> >> - Use this proposed ls1021a_defconfig and remove LS1021A from
> >> imx_v6_v7_defconfig?
> >>
> >> Regards,
> >>
> >> Fabio Estevam
> 
