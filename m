From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 30 Sep 2015 14:44:35 +0800
Subject: [PATCH v4 1/1] clk: imx31: Do not call mxc_timer_init twice when
 booting with DT
In-Reply-To: <1443594220-21183-1-git-send-email-alexander.stein@systec-electronic.com>
References: <1443594220-21183-1-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <20150930064434.GE16362@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 08:23:40AM +0200, Alexander Stein wrote:
> mxc_timer_init must not be called from within mx31_clocks_init_dt. It will
> eventually be called by imx31_timer_init_dt
> (drivers/clocksource/timer-imx-gpt.c).
> This arranges the initialization code similar to clk-imx27.c
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Applied, thanks.
