From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 05 Jan 2017 13:53:44 +0100
Subject: [PATCH v5 4/4] clk: rockchip: add clock controller for rk3328
In-Reply-To: <1482979511-6847-5-git-send-email-zhangqing@rock-chips.com>
References: <1482979511-6847-1-git-send-email-zhangqing@rock-chips.com>
 <1482979511-6847-5-git-send-email-zhangqing@rock-chips.com>
Message-ID: <2499480.rhkWDTFgrm@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 29. Dezember 2016, 10:45:11 CET schrieb Elaine Zhang:
> Add the clock tree definition for the new rk3328 SoC.
> 
> Changes in v5:
>   fix up some code style, remove grf clk init and cru dump.
> Changes in v4:
>   adjust the pacth 3 and 4 order.
> Changes in v3:
>   fix up the pll parent only xin24m.
> Changes in v2:
>   fix up these *_sample error description.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

applied for 4.11.

You might also want to readd your mac2phy grf clocks via the newly
introduced muxgrf clock-type [0] in a follow-up-patch.

Heiko

[0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=cb1d9f6ddaa436f2dce2710740b7a3546700949c
