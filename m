From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 25 Apr 2016 23:02:37 +0200
Subject: [PATCH 3/6] clk: rockchip: rk3399: drop unnecessary
 CLK_IGNORE_UNUSED flags
In-Reply-To: <1461150414-29638-4-git-send-email-zhengxing@rock-chips.com>
References: <1461150414-29638-1-git-send-email-zhengxing@rock-chips.com>
 <1461150414-29638-4-git-send-email-zhengxing@rock-chips.com>
Message-ID: <2170828.EVvy8hQbgu@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 20. April 2016, 19:06:51 schrieb Xing Zheng:
> We don't need to many clocks enable after startup, to reduce some
> power consumption.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

applied to my clk-branch for v4.7

Thanks
Heiko
