From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 04 Sep 2016 23:51:12 +0200
Subject: [v2 PATCH 3/3] clk: rockchip: use the dclk_vop_frac clock ids
In-Reply-To: <1472786785-2393-3-git-send-email-zyw@rock-chips.com>
References: <1472786785-2393-1-git-send-email-zyw@rock-chips.com>
 <1472786785-2393-3-git-send-email-zyw@rock-chips.com>
Message-ID: <2504148.HshbI1VF8K@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 1. September 2016, 20:26:25 CEST schrieb Chris Zhong:
> From: Yakir Yang <ykk@rock-chips.com>
> 
> Export the dclk_vop_frac out, so we can set the dclk_vop as the
> child of dclk_vop_frac, and then we can start to take use of
> the fractional dividers.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>

applied to my clk-branch for 4.9
