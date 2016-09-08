From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 08 Sep 2016 16:29:48 +0200
Subject: [PATCH] arm64: rockchip: fix i2c resource describe error of rk3368
In-Reply-To: <1473332623-31951-1-git-send-email-andy.yan@rock-chips.com>
References: <1473332623-31951-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1501249.i2J5ebpZs6@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 8. September 2016, 19:03:43 CEST schrieb Andy Yan:
> According to the TRM and downstream code from rockchip, the register
> address of i2c1 on rk3368 is 0xff660000 and i2c2 is 0xff140000.
> 
> This patch fix the i2c1 & i2c2 register address definition error, also
> fix the clk and pinctrl reference error.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

after also checking the TRM for confirmation, applied to my dts64 branch


Thanks for catching that
Heiko
