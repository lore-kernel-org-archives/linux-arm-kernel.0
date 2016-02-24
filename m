From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 24 Feb 2016 14:27:43 +0100
Subject: [PATCH 3/4] clk: rockchip: add dt-binding header for rk3399
In-Reply-To: <1456210864-29037-4-git-send-email-jay.xu@rock-chips.com>
References: <1456210864-29037-1-git-send-email-jay.xu@rock-chips.com>
 <1456210864-29037-4-git-send-email-jay.xu@rock-chips.com>
Message-ID: <4483822.0pRK7cKepF@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jianqun,

Am Dienstag, 23. Februar 2016, 15:01:03 schrieb jianqun.xu:
> From: Xing Zheng <zhengxing@rock-chips.com>
> 
> Add the dt-bindings header for the rk3399, that gets shared between
> the clock controller and the clock references in the dts.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>

looks ok so far, do you have an estimate when the revised clk driver will be 
sent? Before committing to support this binding header forever I'd like to 
take a look over the clock-tree itself, just to be sure ;-)


Thanks
Heiko
