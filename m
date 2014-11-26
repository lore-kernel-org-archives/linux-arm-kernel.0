From: bhupesh.sharma@freescale.com (bhupesh.sharma at freescale.com)
Date: Wed, 26 Nov 2014 12:07:27 +0000
Subject: [PATCH v6 0/6] ARM64: Add support for FSL's LS2085A SoC
In-Reply-To: <3137797.TSZb6ObLdd@wuerfel>
References: <1417002447-19163-1-git-send-email-bhupesh.sharma@freescale.com>
 <3137797.TSZb6ObLdd@wuerfel>
Message-ID: <BY1PR0301MB130382E8DEDF303F9AACD40D82700@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Arnd Bergmann [mailto:arnd at arndb.de]
> 
> On Wednesday 26 November 2014 17:17:21 Bhupesh Sharma wrote:
> > This patchset adds the support for FSL's LS2085A SoC which is based on
> > ARMv8 architecture.
> >
> > This patchset also has patches which address DT compatible strings for
> > nodes which appear un-documented.
> >
> > The enable-method for the CPU nodes is left for the bootloader (u-boot
> > or UEFI) to patch-up which is expected to be PSCI v0.2
> 
> If this is a final version, please send it 'To: arm at kernel.org' with
> everyone on Cc and ask for inclusion in the next kernel.

Ok.

> 
> > This patchset has been tested with the following patches which add
> > PSCI
> > v0.2 support in ARMv8 u-boot:
> > http://patchwork.ozlabs.org/patch/383556/
> > http://patchwork.ozlabs.org/patch/383555/
> > http://patchwork.ozlabs.org/patch/383557/
> > http://patchwork.ozlabs.org/patch/383558/
> > http://patchwork.ozlabs.org/patch/383559/
> > http://patchwork.ozlabs.org/patch/383560/
> > http://patchwork.ozlabs.org/patch/383561/
> > http://patchwork.ozlabs.org/patch/383562/
> >
> > Rebased against v3.18-rc6
> >
> 
> When you send a pull request, please always try to base it on top of -rc1
> for practical concerns.
> 
> In this particular case, please base your patches on top of the
> cleanup/dts-subdirs branch of the arm-soc tree, which moves the dts files
> into per-vendor subdirectories.
> 

Sure, Arnd.

Regards,
Bhupesh
