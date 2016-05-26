From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 27 May 2016 01:17:27 +0200
Subject: [PATCH] clk: rockchip: add a dummy clock for the watchdog pclk on
 rk3399
In-Reply-To: <1464166316-22480-1-git-send-email-zhengxing@rock-chips.com>
References: <1464166316-22480-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <7878987.CKGkxk3Y7s@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 25. Mai 2016, 16:51:56 schrieb Xing Zheng:
> Like rk3288, the pclk supplying the watchdog is controlled via the
> SGRF register area. Additionally the SGRF isn't even writable in
> every boot mode.
> 
> But still the clock control is available and in the future someone
> might want to use it. Therefore define a simple clock for the time
> being so that the watchdog driver can read its rate.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

applied for 4.8

Thanks
Heiko
