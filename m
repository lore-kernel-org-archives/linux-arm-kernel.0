From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 17 Jan 2016 20:14:07 +0100
Subject: [PATCH] clk: rockchip: rk3036: enable the CLK_IGNORE_UNUSED flag
 for hclk_vio_bus
In-Reply-To: <1452858854-841-1-git-send-email-ykk@rock-chips.com>
References: <1452858854-841-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1816378.OnNVlMiORS@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 15. Januar 2016, 19:54:14 schrieb Yakir Yang:
> HCLK_VIO_BUS is the noc bus controller clock for display module,
> due to it shouldn't belong to any driver, but we need it enabled,
> so just mark it as the CLK_IGNORE_UNUSED flag.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>

applied to my clk-branch for 4.6

Thanks
Heiko
