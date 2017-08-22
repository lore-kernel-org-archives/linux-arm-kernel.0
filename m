From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 22 Aug 2017 02:56:44 +0200
Subject: [PATCH v2 4/4] clk: rockchip: rv1108: fix up the clk_mac sel
 register description
In-Reply-To: <1503303367-17915-5-git-send-email-zhangqing@rock-chips.com>
References: <1503303367-17915-1-git-send-email-zhangqing@rock-chips.com>
 <1503303367-17915-5-git-send-email-zhangqing@rock-chips.com>
Message-ID: <3808559.a1EKnBSiS9@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 21. August 2017, 16:16:07 CEST schrieb Elaine Zhang:
> cru_sel24_con[8]
> rmii_extclk_sel
> clock source select control register
> 1'b0: from internal PLL
> 1'b1: from external IO
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

applied for 4.14.


Thanks
Heiko
