From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Mar 2016 17:02:32 +0900
Subject: [PATCH v2 0/2] ARM: dts: r8a7793: add CAN to device tree
In-Reply-To: <SG2PR06MB10386A43CDCBE656A3ACBE12C3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
References: <1458001594-632-1-git-send-email-horms+renesas@verge.net.au>
 <SG2PR06MB10386A43CDCBE656A3ACBE12C3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
Message-ID: <20160315080232.GD6912@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2016 at 07:09:23AM +0000, Ramesh Shanmugasundaram wrote:
> Hi Simon,
> 
> > Subject: [PATCH v2 0/2] ARM: dts: r8a7793: add CAN to device tree
> 
> r8a7794?

Yes, my bad.

> > 
> > Hi,
> > 
> > this short series adds CAN clocks and nodes to the r8a7794 device tree.
> > 
> > I am not aware of an r8a7794 board that exposes CAN - neither the alt nor
> > the silk board appear to - and thus am unsure of a way to test these
> > changes.  However, they are based on what is present for the r8a7791 SoC
> > and I am unable to find a difference in the SoC documentation.
> > 
> > This series is similar to a similar series I posted for the r8a7794 in
> > January.
> > 
> > Based on renesas-devel-20160311-v4.5-rc7.
> > 
> > Changes in v2
> > * Correct clock node names
> > * Add MSTP9 clocks
> > * Omit clock-output-names property from new nodes
> 
> Acked-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> 
> for this series.

Thanks
