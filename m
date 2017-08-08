From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 08 Aug 2017 17:36:41 +0200
Subject: [PATCH v3 7/9] clk: rockchip: fix up some clks describe error for
 rv1108 SoC
In-Reply-To: <1502176739-32321-1-git-send-email-zhangqing@rock-chips.com>
References: <1502176547-30817-1-git-send-email-zhangqing@rock-chips.com>
 <1502176739-32321-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <2886228.L8ZHQJ0d60@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 8. August 2017, 15:18:59 CEST schrieb Elaine Zhang:
> 1. fix up the parent name
> 2. remove the CLK_IGNORE_UNUSED flag for some clk not need to always on.
> 3. fix up some clks regs describe error.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

applied for 4.14

Thanks for restructuring the patches
Heiko
