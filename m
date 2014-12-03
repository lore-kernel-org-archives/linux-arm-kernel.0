From: nm@ti.com (Nishanth Menon)
Date: Wed, 3 Dec 2014 07:04:23 -0600
Subject: [PATCH 0/2] ARM: dts: dra7-evm: Regulator max voltage fixes
In-Reply-To: <1417608237-12258-1-git-send-email-rk@ti.com>
References: <1417608237-12258-1-git-send-email-rk@ti.com>
Message-ID: <547F0A57.7040806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2014 06:03 AM, Ravikumar Kattekola wrote:
> Hi,
> 
> This set does a minor fix and an update:
> 
>    - Fix a typo in the max voltage property of smps6 (vdd_gpu) regulator node added by
>      the patch : c56a831ca47e ("ARM: dts: DRA7: Add TPS659038 PMIC nodes")
> 
>    - Update max voltage property of smps7 (vdd_core) regulator node to align with the 
>      latest Data Manual
> 
> Regards,
> RK
> 
> Ravikumar Kattekola (2):
>   ARM: dts: dra7-evm: Fix typo in SMPS6 (VDD_GPU) max voltage
>   ARM: dts: dra7-evm: Update SMPS7 (VDD_CORE) max voltage to match DM
> 
>  arch/arm/boot/dts/dra7-evm.dts  |    4 ++--
>  arch/arm/boot/dts/dra72-evm.dts |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
These apply to

https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v3.19/dt-v2

Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
