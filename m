From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 19 Nov 2018 14:40:06 +0100
Subject: [PATCH] clk: rockchip: fix I2S1 clock gate register for rk3328
In-Reply-To: <20181118041612.2773-1-katsuhiro@katsuster.net>
References: <20181118041612.2773-1-katsuhiro@katsuster.net>
Message-ID: <22369238.AtuRxmQGGH@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 18. November 2018, 05:16:12 CET schrieb Katsuhiro Suzuki:
> This patch fixes definition of I2S1 clock gate register for rk3328.
> Current setting is not related I2S clocks.
>   - bit6 of CRU_CLKGATE_CON0 means clk_ddrmon_en
>   - bit6 of CRU_CLKGATE_CON1 means clk_i2s1_en
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

applied for 4.21


Thanks
Heiko
