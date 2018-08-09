From: robh@kernel.org (Rob Herring)
Date: Thu, 09 Aug 2018 16:41:22 -0600
Subject: [PATCH 7/8] arm64: dts: rk3399: Add dfi and dmc nodes.
In-Reply-To: <20180730081124.30698-8-enric.balletbo@collabora.com>
References: <20180730081124.30698-1-enric.balletbo@collabora.com>
 <20180730081124.30698-8-enric.balletbo@collabora.com>
Message-ID: <5b6cc314.1c69fb81.96ced.16f7@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, this is an automated email from Rob's (experimental) review bot. I
found a couple of common problems with your patch. Please see below.

On Mon, 30 Jul 2018 10:11:23 +0200, Enric Balletbo i Serra wrote:
> From: Lin Huang <hl@rock-chips.com>
> 
> These are required to support DDR DVFS on rk3399 platform. The patch also
> introduces two new files (rk3399-dram.h and rk3399-dram-default-timing)
> with default DRAM settings.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

The preferred subject prefix is "dt-bindings: <binding dir>: ...".

> ---
> 
> Changes in v1:
> - [RFC 8/10] Move rk3399-dram.h to dt-includes.
> - [RFC 8/10] Put sdram default values under the dmc node.
> - [RFC 8/10] Removed rk3399-dram-default-timing.dts
> 
>  .../boot/dts/rockchip/rk3399-op1-opp.dtsi     | 29 ++++++++
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi      | 49 +++++++++++++
>  include/dt-bindings/power/rk3399-dram.h       | 73 +++++++++++++++++++
>  3 files changed, 151 insertions(+)
>  create mode 100644 include/dt-bindings/power/rk3399-dram.h
> 

DT bindings (including binding headers) should be a separate patch. See
Documentation/devicetree/bindings/submitting-patches.txt.
