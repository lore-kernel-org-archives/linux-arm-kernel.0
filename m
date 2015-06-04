From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 4 Jun 2015 15:50:33 -0700
Subject: [PATCH] drivers/clk: convert sunxi/clk-mod0.c to use
 builtin_platform_driver
In-Reply-To: <1433358578-9579-1-git-send-email-paul.gortmaker@windriver.com>
References: <1431287385-1526-1-git-send-email-paul.gortmaker@windriver.com>
 <1433358578-9579-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20150604225033.GD8099@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03, Paul Gortmaker wrote:
> This driver builds based on obj-y and hence will not ever be
> modular.  Change it to use the non-modular registration so that it
> won't suffer a compile fail once a header move places the modular
> registration within the module.h file.
> 
> Cc: "Emilio L?pez" <emilio@elopez.com.ar>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: linux-clk at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
