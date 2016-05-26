From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 26 May 2016 23:47:39 +0200
Subject: [PATCH] clk: rockchip: fix cclk error handing
In-Reply-To: <1464270549-12713-1-git-send-email-zhengxing@rock-chips.com>
References: <1464270549-12713-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1509769.ko7YVcsoMN@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 26. Mai 2016, 21:49:08 schrieb Xing Zheng:
> It maybe due to a copy-paste error the error handing should be
> cclk not clk.
> 
> Reported-by: Lin Huang <lin.huang@rock-chips.com>
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

applied to my clk-fixes branch after adapting the commit message a bit.


Thanks for catching that
Heiko
