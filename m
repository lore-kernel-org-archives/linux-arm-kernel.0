From: mark.yao@rock-chips.com (Mark yao)
Date: Wed, 06 Jan 2016 16:39:24 +0800
Subject: [PATCH v7 0/5] Add mipi dsi support for rk3288
In-Reply-To: <1452053038-32098-1-git-send-email-zyw@rock-chips.com>
References: <1452053038-32098-1-git-send-email-zyw@rock-chips.com>
Message-ID: <568CD2BC.7080800@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?01?06? 12:03, Chris Zhong wrote:
> The rk3288 MIPI DSI is a Synopsys DesignWare MIPI DSI host controller
> IP. This series adds support for a Synopsys DesignWare MIPI DSI host
> controller DRM driver.
>
> The MIPI DSI feature is tested on rk3288 evb board, backport them to
> chrome os kernel chrome_v3.14, and it can display normally.
>
> This patchset is base on the patchset from Ying.liu at freescale.com.
> <http://www.spinics.net/lists/dri-devel/msg77181.html>
>
> According to the suggestion from Thierry, I have get rid of the bridge,
> and register the encoder & connecter in drm/rockchip/dw-mipi-dsi.c.
>
> After backport below patches from linux-next, I can merge this serial into
> Dave's drm-next branch.
>
> 94d5d6a0fbf3 clk: rockchip: add an id for rk3288 crypto clk
> c6d49fbcfcc4 clk: rockchip: add id for mipidsi sclk on rk3288
> a2f4c560f18e clk: rockchip: add mipidsi clock on rk3288
> 69c923743640 ARM: dts: rockchip: correct the name of REG8 for rk3288-evb-act8846
> 662513a14c9d ARM: dts: rockchip: add 2 regulators for rk3288-evb-act8846
> b04061e6599b ARM: dts: rockchip: move the public part to rk3288-evb common
>
>
>
Hi Chris

I had picked following three patches and send a pull-request to Dave
       [PATCH v7 1/5] drm/rockchip: return a true clock rate to 
adjusted_mode
       [PATCH v7 2/5] Documentation: dt-bindings: Add bindings for 
rk3288 DW MIPI DSI driver
       [PATCH v7.2 3/5] drm: rockchip: Support Synopsys DW MIPI DSI

Thanks.

-- 
?ark Yao
