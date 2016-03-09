From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 09 Mar 2016 17:50:17 +0100
Subject: [PATCH v3 3/7] clk: rockchip: add more mux parameters for new pll
 sources
In-Reply-To: <1457491027-30936-4-git-send-email-zhengxing@rock-chips.com>
References: <1457491027-30936-1-git-send-email-zhengxing@rock-chips.com>
 <1457491027-30936-4-git-send-email-zhengxing@rock-chips.com>
Message-ID: <6921896.5phntn5YJn@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 9. M?rz 2016, 10:37:03 schrieb Xing Zheng:
> Thers are only two parent PLLs that APLL and GPLL for core on the
> previous SoCs (RK3066/RK3188/RK3288/RK3368). Hence, we set fixed
> GPLL as alternate parent when core is switching freq.
> 
> Since RK3399 big.LITTLE architecture, we need to select and adapt
> more PLLs (ALPLL/ABPLL/DPLL/GPLL) sources.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

applied to my clk-branch for v4.7, with an adapted subject of
"clk: rockchip: allow varying mux parameters for cpuclk pll-sources"


Thanks
Heiko
