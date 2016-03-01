From: ramesh.shanmugasundaram@bp.renesas.com (Ramesh Shanmugasundaram)
Date: Tue, 1 Mar 2016 08:20:25 +0000
Subject: [PATCH] arm64: dts: r8a7795: Add CAN support
In-Reply-To: <56D54EFA.6020105@pengutronix.de>
References: <1456755759-51288-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56D54EFA.6020105@pengutronix.de>
Message-ID: <SG2PR06MB103895394DED2A849E2A801BC3BB0@SG2PR06MB1038.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

> On 02/29/2016 03:22 PM, Ramesh Shanmugasundaram wrote:
> > Adds CAN controller nodes for r8a7795.
> >
> > Note: CAN channel register base address mentioned in R-Car Gen3
> > Hardware User Manual v0.5E is incorrect. The corrected base addresses
> are:
> >
> > CAN Channel 0 - 0xe6c30000
> > CAN Channel 1 - 0xe6c38000
> >
> > Signed-off-by: Ramesh Shanmugasundaram
> > <ramesh.shanmugasundaram@bp.renesas.com>
> > ---
> > Hi All,
> >
> >    This patch is based on linux-next (tag:next-20160225) with following
> patch
> >    applied on top
> 
> Who should take this patch?

If acked, I think it is Simon (who consolidates all Renesas ARM64 DT changes and make one pull request). Copied Geert too.

Thanks,
Ramesh
