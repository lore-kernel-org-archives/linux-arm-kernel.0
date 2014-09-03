From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 17:29:49 +0200
Subject: [PATCH V3 0/6] ARM64: Add support for FSL's LS2085A SoC
In-Reply-To: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <11626142.L1WDF72bmp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 20:43:08 Bhupesh Sharma wrote:
> 
> In this version, the enable-method for the CPU nodes is left for the
> bootloader (u-boot or UEFI) to patch-up. This DTS has been tested for
> PSCI v0.2 CPU_ON method (and corresponding secondary boot) using the
> following ARMv8 u-boot patches:

What would be a reason for using something other than PSCI?

	Arnd
