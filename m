From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 05 Mar 2018 21:26:23 +0100
Subject: [PATCH] soc: rockchip: power-domain: Add a sanity check on
 pd->num_clks
In-Reply-To: <20180305091722.22246-1-jeffy.chen@rock-chips.com>
References: <20180305091722.22246-1-jeffy.chen@rock-chips.com>
Message-ID: <2446754.ohlkqz2d1D@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 5. M?rz 2018, 10:17:22 CET schrieb Jeffy Chen:
> The of_count_phandle_with_args() can fail and return error(for example,
> rk3399 pd_vio doesn't have clocks). That would break the pd probe.
> 
> Add a sanity check on pd->num_clks to avoid that.
> 
> Fixes: 65084121d59d ("soc: rockchip: power-domain: use clk_bulk APIs")
> Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

applied for 4.17


Thanks
Heiko
