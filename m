From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Tue, 7 Feb 2017 14:55:27 +0000
Subject: [PATCH 00/10][v2] staging: fsl-mc: fixes and cleanups
In-Reply-To: <20170207141530.12979-1-laurentiu.tudor@nxp.com>
References: <20170207141530.12979-1-laurentiu.tudor@nxp.com>
Message-ID: <VI1PR0401MB26382133D431E0AFABC185F98D430@VI1PR0401MB2638.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: laurentiu.tudor at nxp.com [mailto:laurentiu.tudor at nxp.com]
> Sent: Tuesday, February 07, 2017 8:15 AM
> To: gregkh at linuxfoundation.org
> Cc: devel at driverdev.osuosl.org; linux-kernel at vger.kernel.org; agraf at suse.de; arnd at arndb.de; Ioana
> Ciornei <ioana.ciornei@nxp.com>; Ruxandra Ioana Radulescu <ruxandra.radulescu@nxp.com>; Bharat Bhushan
> <bharat.bhushan@nxp.com>; Stuart Yoder <stuart.yoder@nxp.com>; Catalin Horghidan
> <catalin.horghidan@nxp.com>; Leo Li <leoyang.li@nxp.com>; Roy Pledge <roy.pledge@nxp.com>; linux-arm-
> kernel at lists.infradead.org; Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Subject: [PATCH 00/10][v2] staging: fsl-mc: fixes and cleanups
> 
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> First 4 patches fix several driver model related
> issues and drop an useless atomic global.
> The rest of the patches are cleanups mostly
> consisting in removing dead code.
> 
> v2:
>  - split slab cache removal in distinct patch
>  - redundant deallocation dropped in patch that adds release callback

Laurentiu,

A few nits about this submission:

-every patch in the series should have had "v2" in the patch
 subject.  In your submission only the cover letter had it.
 Without that it's harder to keep track of which version of
 patch I'm looking at.  Just use this when formatting your
 patches:
     --patch-subject="PATCH v2"

-for each patch, you should note below the "---" what changed in the
 patch, and if there were no changes you put "no changes".  For
 an example see:
     https://patchwork.kernel.org/patch/9478093/

 (You can use "git notes" to manage the below the "---" comments
  if it helps)

Can you reformat this series with "v3" and add the the comments
to note what did not change and what did change?

Thanks,
Stuart
