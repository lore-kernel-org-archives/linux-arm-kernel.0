From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 18 Jan 2017 11:25:21 +0100
Subject: [PATCH] clk: rockchip: fix the incorrect pclk_edp div width for
 RK3399
In-Reply-To: <1484713256-3005-1-git-send-email-zhengxing@rock-chips.com>
References: <1484713256-3005-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1739624.bC7E8g3lgy@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 18. Januar 2017, 12:20:56 CET schrieb Xing Zheng:
> The range of the  pclk_edp_div_con is [13:8] and 6 bits, not 5.
> 
> Reported-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

applied for 4.11 with Lin's test tag


Thanks
Heiko
