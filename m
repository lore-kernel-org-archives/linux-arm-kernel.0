From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sat, 2 Dec 2017 20:01:40 -0800
Subject: [PATCH 0/6] 66AK2G: Add DT nodes for few peripherals
In-Reply-To: <20171123075154.3938-1-vigneshr@ti.com>
References: <20171123075154.3938-1-vigneshr@ti.com>
Message-ID: <9a1a50a9-d77e-44fb-be47-32fb8d4735f2@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/17 11:51 PM, Vignesh R wrote:
> This patch series adds DT nodes for bunch of peripherials on 66AK2G EVM and
> 66AK2G ICE boards.
> 
> Tested on 66AK2G EVM and ICE boards
> 
> 
> Vignesh R (6):
>    ARM: dts: keystone-k2g: Add QSPI DT entry
>    ARM: dts: keystone-k2g-evm: Fix botched up merge
>    ARM: dts: keystone-k2g: Move ti,non-removable property to board dts
>    ARM: dts: keystone-k2g-evm: Add QSPI DT node.
>    ARM: dts: keystone-k2g-ice: Add DT nodes for few peripherals
>    ARM: configs: keystone_defconfig: Enable few peripheral drivers
> 
Series applied. Please submit the follow up patch for
multi-v7 config.

Regards,
Santosh
