From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 31 Dec 2016 13:53:51 +0100
Subject: [PATCH v5 3/4] clk: rockchip: add new pll-type for rk3328
In-Reply-To: <1482979511-6847-4-git-send-email-zhangqing@rock-chips.com>
References: <1482979511-6847-1-git-send-email-zhangqing@rock-chips.com>
 <1482979511-6847-4-git-send-email-zhangqing@rock-chips.com>
Message-ID: <2438805.XRRMBVrdEM@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 29. Dezember 2016, 10:45:10 CET schrieb Elaine Zhang:
> The rk3328's pll and clock are similar with rk3036's,
> it different with pll_mode_mask, the rk3328 soc
> pll mode only one bit(rk3036 soc have two bits)
> so these should be independent and separate from
> the series of rk3328s.
> 
> Changes in v4:
>   adjust the pacth 3 and 4 order.
>   move pll_rk3328 to patch 3.
> Changes in v3:
>   fix up the pll type pll_rk3328 description and use
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

applied to my clk-branch for 4.11

The clock controller itself also looks good now, I'll just give Rob or someone 
else a bit of time for eventual comments after new years :-)

Heiko
