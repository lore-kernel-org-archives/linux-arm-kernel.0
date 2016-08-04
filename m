From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 05 Aug 2016 00:37:03 +0200
Subject: [PATCH v4 1/7] clk: rockchip: add clock flag parameter when
 register pll
In-Reply-To: <1469779021-10426-2-git-send-email-hl@rock-chips.com>
References: <1469779021-10426-1-git-send-email-hl@rock-chips.com>
 <1469779021-10426-2-git-send-email-hl@rock-chips.com>
Message-ID: <4870605.nd4Eof6Gm1@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 29. Juli 2016, 15:56:55 schrieb Lin Huang:
> From: Heiko St?bner <heiko@sntech.de>
> 
> add clock flag parameter so we can pass specific clock flag
> (like CLK_GET_RATE_NOCACHE etc..)to pll driver.
> 
> Signed-off-by: Heiko St?bner <heiko@sntech.de>
> Signed-off-by: Lin Huang <hl@rock-chips.com>

applied to my clock branch for 4.9 after some minor edits on the commit 
message.


Thanks
Heiko
