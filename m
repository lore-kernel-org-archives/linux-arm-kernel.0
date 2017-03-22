From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 22 Mar 2017 19:07:39 +0100
Subject: [PATCH v1] clk: rockchip: add pll_wait_lock for pll_enable
In-Reply-To: <1487732395-30353-1-git-send-email-zhangqing@rock-chips.com>
References: <1487732395-30353-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1524529.CszJHdUNkn@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 22. Februar 2017, 10:59:55 CET schrieb Elaine Zhang:
> If pll is power down,when power up pll need wait pll lock.
> The reference documents section:
> 	PLL frequency change and lock check
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

applied to my clk-branch for 4.12


Thanks
Heiko
