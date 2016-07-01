From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 01 Jul 2016 10:31:54 +0200
Subject: [PATCH] clk: rockchip: fix the rk3399 spdif incorrect bit for DPTX
In-Reply-To: <1467253139-21112-1-git-send-email-zhengxing@rock-chips.com>
References: <1467253139-21112-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <2167990.nRjYb2NtK4@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 30. Juni 2016, 10:18:59 schrieb Xing Zheng:
> The CLKSEL_CON32 bit_0 is controlled for spdif_8ch, not spdif_rec_dptx,
> it should be bit_8, let's fix it.
> 
> Reported-by: Chris Zhong <zyw@rock-chips.com>
> Tested-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

applied to my clk branch for 4.8
