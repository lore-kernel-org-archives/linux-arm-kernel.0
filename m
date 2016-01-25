From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 25 Jan 2016 11:14:28 +0100
Subject: [PATCH v1 0/3] clk: rockchip: rk3368: fix some error for rk3368
 clk
In-Reply-To: <1453740962-8556-1-git-send-email-zhangqing@rock-chips.com>
References: <1453740962-8556-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1616798.0SYvlcg7vJ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Montag, 25. Januar 2016, 08:55:59 schrieb Zhang Qing:
> From: zhangqing <zhangqing@rock-chips.com>
> 
> modify edp_24m parent select bit.
> enable CLK_SET_RATE_PARENT flag for spdif_8ch and i2s_2ch.
> 
> zhangqing (3):
>   clk: rockchip: rk3368: fix edp_24m parent
>   clk: rockchip: rk3368: enable the CLK_SET_RATE_PARENT flag for
>     spdif_8ch
>   clk: rockchip: rk3368: enable the CLK_SET_RATE_PARENT flag for i2s_2ch

applied all 3 to my clk branch for 4.6.

I've modified patches 2+3 to keep the line-alingment (= move the CLK_SET_PARENT 
to the line above). In the clock trees I really like to keep the structure 
identical over all clocks (and thus ignore the 80 column limit in parts) to 
make reading the large lists easier, as now everything always is in the same 
place.


Heiko
