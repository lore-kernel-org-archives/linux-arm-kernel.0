From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Wed, 8 Feb 2017 20:50:28 +0000
Subject: [PATCH v3 00/10] staging: fsl-mc: fixes and cleanups
In-Reply-To: <20170207154353.20691-1-laurentiu.tudor@nxp.com>
References: <20170207154353.20691-1-laurentiu.tudor@nxp.com>
Message-ID: <VI1PR0401MB2638C4344C5C81364C5A0AF08D420@VI1PR0401MB2638.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: laurentiu.tudor at nxp.com [mailto:laurentiu.tudor at nxp.com]
> Sent: Tuesday, February 07, 2017 9:44 AM
> To: gregkh at linuxfoundation.org
> Cc: devel at driverdev.osuosl.org; linux-kernel at vger.kernel.org; agraf at suse.de; arnd at arndb.de; Ioana
> Ciornei <ioana.ciornei@nxp.com>; Ruxandra Ioana Radulescu <ruxandra.radulescu@nxp.com>; Bharat Bhushan
> <bharat.bhushan@nxp.com>; Stuart Yoder <stuart.yoder@nxp.com>; Catalin Horghidan
> <catalin.horghidan@nxp.com>; Leo Li <leoyang.li@nxp.com>; Roy Pledge <roy.pledge@nxp.com>; linux-arm-
> kernel at lists.infradead.org; Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Subject: [PATCH v3 00/10] staging: fsl-mc: fixes and cleanups
> 
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> First 4 patches fix several driver model related
> issues and drop an useless atomic global.
> The rest of the patches are cleanups mostly
> consisting in removing dead code.
> 
> Only patch 3, 4, 5 and 10 changed. See individual patch notes for
> details.
> 
> Laurentiu Tudor (10):
>   staging: fsl-mc: drop root dprc counting
>   staging: fsl-mc: fix device ref counting
>   staging: fsl-mc: add device release callback
>   staging: fsl-mc: don't use devres api for refcounted objects
>   staging: fsl-mc: remove slab cache for mc devices
>   staging: fsl-mc: dpmcp: drop unused APIs
>   staging: fsl-mc: dpmng: drop unused prototype
>   staging: fsl-mc: dpbp: drop unused APIs
>   staging: fsl-mc: dpbp: add a few missing EXPORT_SYMBOL()s
>   staging: fsl-mc: dprc: drop unused APIs

For the series:

Acked-by: Stuart Yoder <stuart.yoder@nxp.com>
