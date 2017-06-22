From: ruxandra.radulescu@nxp.com (Ruxandra Ioana Radulescu)
Date: Thu, 22 Jun 2017 15:50:13 +0000
Subject: [PATCH] staging: fsl-dpaa2/eth: fix a couple of implicit includes
In-Reply-To: <20170622125210.27269-1-laurentiu.tudor@nxp.com>
References: <20170622125210.27269-1-laurentiu.tudor@nxp.com>
Message-ID: <VI1PR0402MB2847D208F6FCC695225A58C394DB0@VI1PR0402MB2847.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: laurentiu.tudor at nxp.com [mailto:laurentiu.tudor at nxp.com]
> Sent: Thursday, June 22, 2017 3:52 PM
> To: gregkh at linuxfoundation.org; Ruxandra Ioana Radulescu
> <ruxandra.radulescu@nxp.com>
> Cc: devel at driverdev.osuosl.org; linux-kernel at vger.kernel.org; Bogdan
> Purcareata <bogdan.purcareata@nxp.com>; Leo Li <leoyang.li@nxp.com>;
> stuyoder at gmail.com; Roy Pledge <roy.pledge@nxp.com>; linux-arm-
> kernel at lists.infradead.org; Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Subject: [PATCH] staging: fsl-dpaa2/eth: fix a couple of implicit includes
> 
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> dpni.c is using byte order macros and error codes but does
> not explicitly include the required kernel header, so add it.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
 
Acked-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
