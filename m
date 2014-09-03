From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 17:39:07 +0200
Subject: [PATCH V3 0/6] ARM64: Add support for FSL's LS2085A SoC
In-Reply-To: <d856a7c55a0949cd918411f3f834bbe3@BN1PR03MB220.namprd03.prod.outlook.com>
References: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
 <11626142.L1WDF72bmp@wuerfel>
 <d856a7c55a0949cd918411f3f834bbe3@BN1PR03MB220.namprd03.prod.outlook.com>
Message-ID: <9081864.6l1AHRQ5bg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 15:36:44 bhupesh.sharma at freescale.com wrote:
> > On Wednesday 03 September 2014 20:43:08 Bhupesh Sharma wrote:
> > >
> > > In this version, the enable-method for the CPU nodes is left for the
> > > bootloader (u-boot or UEFI) to patch-up. This DTS has been tested for
> > > PSCI v0.2 CPU_ON method (and corresponding secondary boot) using the
> > > following ARMv8 u-boot patches:
> > 
> > What would be a reason for using something other than PSCI?
> > 
> 
> We had originally gone ahead and implemented spin-table release method in ARMv8 u-boot
> (see [1]) (the v3 of that patchset is still in works), but we have since been pointed towards
> PSCI by Mark and Catalin, so we have implemented PSCI in ARMv8 u-boot and the v2 and v3
> of the DTS patchset have been tested with both the spin-table and PSCI approaches.
> 
> [1] http://lists.denx.de/pipermail/u-boot/2014-June/182759.html
> 

Would it be possible then to just mandate PSCI for the upstream-supported
version?

	Arnd
