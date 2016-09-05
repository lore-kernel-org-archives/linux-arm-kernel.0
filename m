From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 06 Sep 2016 00:20:58 +0200
Subject: [PATCH v3 1/2] arm64: dts: rockchip: change all interrupts cells
 for 4 on rk3399 SoCs
In-Reply-To: <1473099435-28198-2-git-send-email-wxt@rock-chips.com>
References: <1473099435-28198-1-git-send-email-wxt@rock-chips.com>
 <1473099435-28198-2-git-send-email-wxt@rock-chips.com>
Message-ID: <3069982.xePB5pcLZB@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 6. September 2016, 02:17:14 CEST schrieb Caesar Wang:
> Add the interrupts cells value for 4, and the 4th cell is zero.
> 
> Due to the doc[0] said:" the system requires describing PPI affinity,
> then the value must be at least 4"
> The 4th cell is a phandle to a node describing a set of CPUs this
> interrupt is affine to. The interrupt must be a PPI, and the node
> pointed must be a subnode of the "ppi-partitions" subnode. For
> interrupt types other than PPI or PPIs that are not partitionned,
> this cell must be zero. See the "ppi-partitions" node description
> below.
> 
> [0]:
> Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> CC: linux-arm-kernel at lists.infradead.org

applied to my dts64 branch for 4.9

Thanks
Heiko
