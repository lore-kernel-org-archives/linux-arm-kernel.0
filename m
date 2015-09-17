From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 17 Sep 2015 09:10:08 +0800
Subject: [PATCH v3] ARM: configs: Add Freescale LS1021A defconfig
In-Reply-To: <BN3PR0301MB0867F79377E77636E8B80EEEFE5B0@BN3PR0301MB0867.namprd03.prod.outlook.com>
References: <1438941784-38403-1-git-send-email-b18965@freescale.com>
 <55CB4829.40204@freescale.com> <55CE1FFE.2080200@freescale.com>
 <CAOMZO5By_15OCsb7z2pbywPi3n9vKGj=393hWYHVEQ32=jDNaA@mail.gmail.com>
 <BN3PR0301MB08672520CA978383BBF2CF6CFE790@BN3PR0301MB0867.namprd03.prod.outlook.com>
 <55D6073C.1020000@freescale.com>
 <BN3PR0301MB0867591B07957C47F30C9711FE6E0@BN3PR0301MB0867.namprd03.prod.outlook.com>
 <CAOMZO5DY+HqH-FeFF5rD5rCettfdmni62nHJRAPU5fdXijw=sA@mail.gmail.com>
 <BN3PR0301MB0867F79377E77636E8B80EEEFE5B0@BN3PR0301MB0867.namprd03.prod.outlook.com>
Message-ID: <20150917011008.GI30746@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 08:22:56AM +0000, Huan Wang wrote:
> Hi, Shawn,
> 
> > On Fri, Aug 28, 2015 at 5:04 AM, Huan Wang <alison.wang@freescale.com>
> > wrote:
> > 
> > > I need Fabio's confirmation about removing CONFIG_SOC_LS1021A from
> > imx_v6_v7_config.
> > >
> > > Fabio, Do you agree it?
> > 
> > Yes, if Shawn accepts ls1021a_defconfig then we should remove
> > CONFIG_SOC_LS1021A from imx_v6_v7_config.
> > 
> [Alison Wang] Could you help to review this patch?

Can you please resend the patch with some explanation in the commit log
on why we need a new defconfig, i.e. why imx_v6_v7_config doesn't work
for LS1021A.

Shawn
