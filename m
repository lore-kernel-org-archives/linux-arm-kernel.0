From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 09 Mar 2016 02:12:31 +0100
Subject: [RESEND PATCH v2 1/5] clk: rockchip: add more mux parameters for
 new pll sources
In-Reply-To: <1456827275-8035-2-git-send-email-zhengxing@rock-chips.com>
References: <1456827275-8035-1-git-send-email-zhengxing@rock-chips.com>
 <1456827275-8035-2-git-send-email-zhengxing@rock-chips.com>
Message-ID: <2242962.kh0Ty0L2C4@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 1. M?rz 2016, 18:14:31 schrieb Xing Zheng:
> Thers are only two parent PLLs that APLL and GPLL for core on the
> previous SoCs (RK3066/RK3188/RK3288/RK3368). Hence, we set fixed
> GPLL as alternate parent when core is switching freq.
> 
> Since RK3399 big.LITTLE architecture, we need to select and adapt
> more PLLs (ALPLL/ABPLL/DPLL/GPLL) sources.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

note to self: looks good to go
