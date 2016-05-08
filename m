From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 08 May 2016 22:51:14 +0200
Subject: [PATCH] clk: rockchip: fix the rk3399 sdmmc sample / drv name
In-Reply-To: <1462404985-27957-1-git-send-email-dianders@chromium.org>
References: <1462404985-27957-1-git-send-email-dianders@chromium.org>
Message-ID: <4645491.pfFL9jxaO2@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 4. Mai 2016, 16:36:25 schrieb Douglas Anderson:
> The rk3399 clock table had a simple typo in it, calling the SDMMC sample
> and drive clocks by the wrong name.  Fix this minor typo.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied to my clk-branch


Thanks for catching this
Heiko
