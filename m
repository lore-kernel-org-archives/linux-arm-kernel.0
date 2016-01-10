From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 10 Jan 2016 10:59:13 +0100
Subject: [PATCH] dt-bindings: Fix the external clock name for the RK3036
 EMAC
In-Reply-To: <1452410557-29208-1-git-send-email-zhengxing@rock-chips.com>
References: <1452410557-29208-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <4001585.V8iyL2PDAE@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xing,

Am Sonntag, 10. Januar 2016, 15:22:37 schrieb Xing Zheng:
> Because the RK3036 doesn't support EMAC, and only support the RMII mode
> in the EMAC IP, we refer to the TRM CRU and update the new external
> clock name for EMAC.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

as I said in the other mail, I already fixed the original patch myself :-)
So I'm just going to drop this one.


Heiko

https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v4.5-clk/fixes&id=88807906af108a8384d77ad9cfb9421f164ea931
