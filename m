From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 17 Jan 2016 20:26:37 +0100
Subject: [PATCH v3 5/9] ARM: dts: rockchip: enable the high speed on sdio
 for kylin board
In-Reply-To: <1452865796-23527-6-git-send-email-wxt@rock-chips.com>
References: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
 <1452865796-23527-6-git-send-email-wxt@rock-chips.com>
Message-ID: <4961569.46y83h10I6@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 15. Januar 2016, 21:49:52 schrieb Caesar Wang:
> We want to the higher speed for wifi module working.
> 
> Bootup kernel log:
> ...
> mmc_host mmc0: Bus speed (slot 0) = 37125000Hz (slot req 37500000Hz,
> actual 37125000HZ div = 0)
> 
> or run 'cat /sys/kernel/debug/clk/clk_summary |grep phase -C 1' to check
> Otherwise, the mmc0 will run 400khz defalult value to work.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied to my dts32 branch for 4.6
