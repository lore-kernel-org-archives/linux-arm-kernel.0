From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 10 Mar 2017 11:45:36 +0100
Subject: [PATCH v2 0/5] clk: rockchip: fix up the clk for RK3368 SoC
In-Reply-To: <1488884719-10350-1-git-send-email-zhangqing@rock-chips.com>
References: <1488884719-10350-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <3564953.RFZXb1jYdB@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 7. M?rz 2017, 19:05:14 CET schrieb Elaine Zhang:
> change in V2:
> split clock-id addition and the assignment in the clock-
> driver.
> 
> Elaine Zhang (5):
>   clk: rockchip: rk3368: fix up the timer-ids
>   clk: rockchip: rk3368: remove the unused id

folded this into the first patch and added a commit message explaining the 
timer-id circumstances

>   clk: rockchip: add clock ids for timer10-15 of RK3368 SoCs
>   clk: rockchip: rk3368: export SCLK_TIMERXX id for timers
>   clk: rockchip: rk3368: add some clks as critical

applied with some minor corrections to the subject (rk3368 in the regular 
wording) for 4.12


Thanks
Heiko
