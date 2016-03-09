From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 09 Mar 2016 13:35:05 +0100
Subject: [PATCH v3 6/7] clk: rockchip: add a COMPOSITE_FRACMUX_NOGATE type
In-Reply-To: <1457491411-31114-1-git-send-email-zhengxing@rock-chips.com>
References: <1457491027-30936-1-git-send-email-zhengxing@rock-chips.com>
 <1457491411-31114-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <3000848.liT5htmroZ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 9. M?rz 2016, 10:43:31 schrieb Xing Zheng:
> Because there are some frac clock mux nodes don't need gate node on
> the RK3399.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

applied to my clk-branch for 4.7 after checking the TRM and replacing

"don't need gate node " with "don't have a gate node" :-)


Heiko
