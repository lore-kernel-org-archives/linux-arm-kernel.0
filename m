From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 02 Jun 2017 16:10:19 +0200
Subject: [PATCH v3 0/4] make some special clk as critical_clocks
In-Reply-To: <1493710446-7203-1-git-send-email-zhangqing@rock-chips.com>
References: <1493710446-7203-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <2347847.YaA7RMd5sr@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 2. Mai 2017, 15:34:02 CEST schrieb Elaine Zhang:
> change in V3:
> reword the commit message,explain why the specific clocks are need to be critical.
> 
> change in v2:
> fix up some clks which have their own driver, not need to set as critical clocks
> 
> Elaine Zhang (4):
>   clk: rockchip: rk3036: make pclk_ddrupctl as critical_clock
>   clk: rockchip: rk3228: make noc and some special clk as
>     critical_clocks
>   clk: rockchip: rk3288: make noc and some special clk as
>     critical_clocks
>   clk: rockchip: rk3368: make some special clk as critical_clocks

applied all 4 for 4.13


Thanks
Heiko
