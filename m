From: bhupesh.sharma@freescale.com (bhupesh.sharma at freescale.com)
Date: Sat, 15 Nov 2014 11:06:42 +0000
Subject: [PATCH v5 0/6] ARM64: Add support for FSL's LS2085A SoC
In-Reply-To: <1482989.i0U06CvWpS@wuerfel>
References: <1416048391-7557-1-git-send-email-bhupesh.sharma@freescale.com>
 <1482989.i0U06CvWpS@wuerfel>
Message-ID: <bf2f6ea889034e288f3d4a976df9d16f@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Saturday, November 15, 2014 4:32 PM
> To: Sharma Bhupesh-B45370
> Cc: Catalin.Marinas at arm.com; mark.rutland at arm.com; linux-arm-
> kernel at lists.infradead.org; grant.likely at secretlab.ca;
> marc.zyngier at arm.com; rob.herring at linaro.org;
> bhupesh.sharma at freescal.com; Yoder Stuart-B08248;
> arnab_basu at rocketmail.com
> Subject: Re: [PATCH v5 0/6] ARM64: Add support for FSL's LS2085A SoC
> 
> On Saturday 15 November 2014 16:16:25 Bhupesh Sharma wrote:
> > This patchset adds the support for FSL's LS2085A SoC which is based on
> > ARMv8 architecture.
> >
> > This patchset also has patches which address DT compatible strings for
> > nodes which appear un-documented.
> >
> > The enable-method for the CPU nodes is left for the bootloader (u-boot
> > or UEFI) to patch-up which is expected to be PSCI v0.2
> >
> 
> Looks all good to me. Are you planning to send a pull request to
> arm at kernel.org, or should we pick up the patches directly (provided no
> more new review comments)?
> 

It would be great if you can pick the patches directly (ofcourse, if there are
no new comments).

Thanks for all your help.

Regards,
Bhupesh
