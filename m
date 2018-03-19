From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 19 Mar 2018 13:52:33 -0700
Subject: [RESEND PATCH] clk: enable hi655x common clk automatically
In-Reply-To: <20180312104945.3001-1-riku.voipio@linaro.org>
References: <20180312104945.3001-1-riku.voipio@linaro.org>
Message-ID: <152149275385.242365.18026048344034278094@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting riku.voipio at linaro.org (2018-03-12 03:49:45)
> From: Riku Voipio <riku.voipio@linaro.org>
> 
> Without COMMON_CLK_HI655X Wifi and bluetooth are non-functional on Hikey.
> As suggested by Arnd, enable the driver automatically when the parent
> driver is selected. With sensible defaults in place, we can leave other
> choices for EXPERT.
> 
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@linaro.org>
> Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
> ---

Applied to clk-next
