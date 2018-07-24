From: ruxandra.radulescu@nxp.com (Ioana Ciocoi Radulescu)
Date: Tue, 24 Jul 2018 14:38:33 +0000
Subject: [PATCH v3 0/4] staging/fsl-mc/bus: Move DPIO from staging to
 drivers/soc/fsl
In-Reply-To: <VI1PR0402MB3485147A99F219D5FA1B668B98550@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <20180724142131.28970-1-roy.pledge@nxp.com>
 <VI1PR0402MB3485147A99F219D5FA1B668B98550@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Message-ID: <AM3PR04MB33800EB3509E6715AC49DC294550@AM3PR04MB338.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Horia Geanta
> Sent: Tuesday, July 24, 2018 5:35 PM
> To: Roy Pledge <roy.pledge@nxp.com>; devel at driverdev.osuosl.org; linux-
> arm-kernel at lists.infradead.org; gregkh at linuxfoundation.org; Leo Li
> <leoyang.li@nxp.com>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>; Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>; linux-kernel at vger.kernel.org;
> arnd at arndb.de; catalin.marinas at arm.com; robin.murphy at arm.com
> Subject: Re: [PATCH v3 0/4] staging/fsl-mc/bus: Move DPIO from staging to
> drivers/soc/fsl
> 
> On 7/24/2018 5:21 PM, Roy Pledge wrote:
> > Move the NXP DPIO (Datapath I/O driver) from the staging/fsl-
> mc/bus/dpio
> > directory to the drivers/soc/fsl directory.
> >
> > The DPIO driver enables access to the Queue and Buffer Managemer
> (QBMAN)
> > hardware of NXP DPAA2 devices. This is a prerequiste for moving the
> DPAA2
> > Ethernet device driver from the staging directory.
> >
> For the series:
> Reviewed-by: Horia Geant? <horia.geanta@nxp.com>

Also:
Reviewed-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
