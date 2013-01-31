From: avinashphilip@ti.com (Philip, Avinash)
Date: Thu, 31 Jan 2013 09:36:10 +0000
Subject: [PATCH v2 0/3] Add device tree support for NAND flash in
 am335x-evm
In-Reply-To: <cover.1359007746.git.avinashphilip@ti.com>
References: <cover.1359007746.git.avinashphilip@ti.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EA68A6D@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit,

On Thu, Jan 24, 2013 at 13:32:26, Philip, Avinash wrote:
> This patch series adds device tree support for NAND flash in am335x-evm.
> Also ELM node is populated in device tree and been used for BCH error
> correction in NAND flash part. Also this patch series ensures RBL ecc
> layout maintained in Linux kernel with BCH8 ecc scheme.
> 
> This patch series based on [1] and depends on [2].
> 
> 1. http://git.kernel.org/?p=linux/kernel/git/bcousson/linux-omap-dt.git;a=tree;h=refs/heads/for_3.9/dts;hb=refs/heads/for_3.9/dts
> 
> 2.mtd: devices: elm: Removes <xx> literals in elm DT node
>   https://lkml.org/lkml/2013/1/24/30
> 

Can you accept this patch series so that NAND flash with BCH support
for am335x-evm available in 3.9.

Thanks
Avinash


> Philip Avinash (1):
>   ARM: dts: AM33XX: Add NAND flash device tree data to am335x-evm
> 
> Philip, Avinash (2):
>   ARM: dts: AM33XX: Add ELM node
>   ARM: dts: AM33XX: Add GPMC node
> 
>  arch/arm/boot/dts/am335x-evm.dts |   98 +++++++++++++++++++++++++++++++++++++-
>  arch/arm/boot/dts/am33xx.dtsi    |   20 ++++++++
>  2 files changed, 117 insertions(+), 1 deletion(-)
> 
> -- 
> 1.7.9.5
> 
> 
