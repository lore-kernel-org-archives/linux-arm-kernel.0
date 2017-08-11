From: rui.zhang@intel.com (Zhang Rui)
Date: Fri, 11 Aug 2017 12:51:35 +0800
Subject: [PATCH v2 0/5] thermal: rockchip: add tsadc support in thermal
 driver and IPA thermal control for rk3328 in dts
In-Reply-To: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com>
References: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com>
Message-ID: <1502427095.2598.21.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-08-04 at 16:06 +0800, Rocky Hao wrote:
> This series patches add the tsadc support in thermal driver and in
> devicetree for rk3328.
> Also add thermal control with Intelligent Power Allocation (IPA)
> policy by default.??Please
> refer to https://developer.arm.com/open-source/intelligent-power-allo
> cation for more information
> about IPA.
> 
> Rocky Hao (5):
> ? dt-bindings: rockchip-thermal: Support the RK3328 SoC compatible
> ? thermal: rockchip: Support the RK3328 SOC in thermal driver
> ? arm64: dts: rockchip: add tsadc node for rk3328 SoC
> ? arm64: dts: rockchip: add thermal nodes for rk3328 SoC
> ? arm64: dts: rockchip: Enable tsadc module on RK3328 eavluation
> board
> 
I can take this patch set if we have ACK for patch 3, 4 and 5.

thanks,
rui
> ?.../bindings/thermal/rockchip-thermal.txt??????????|??1 +
> ?arch/arm64/boot/dts/rockchip/rk3328-evb.dts????????|??4 ++
> ?arch/arm64/boot/dts/rockchip/rk3328.dtsi???????????| 63
> +++++++++++++++++++++
> ?drivers/thermal/rockchip_thermal.c?????????????????| 65
> ++++++++++++++++++++++
> ?4 files changed, 133 insertions(+)
> 
