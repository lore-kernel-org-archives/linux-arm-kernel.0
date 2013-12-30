From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 30 Dec 2013 18:51:06 +0100
Subject: [PATCH] clk: exynos: File scope reg_save array should depend on
 PM_SLEEP
In-Reply-To: <20131219075510.18119.67210@quantum>
References: <1387274199-470-1-git-send-email-k.kozlowski@samsung.com>
 <20131219075510.18119.67210@quantum>
Message-ID: <24377867.Lxp9m9lerI@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 of December 2013 23:55:10 Mike Turquette wrote:
> Quoting Krzysztof Kozlowski (2013-12-17 01:56:39)
> > Move reg_save[] into CONFIG_PM_SLEEP dependency block as it is used only
> > by suspend and resume functions.
> > 
> > This fixes the warning on CONFIG_PM_SLEEP=n:
> > drivers/clk/samsung/clk-exynos-audss.c:29:22: warning: ?reg_save? defined but not used [-Wunused-variable]
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Acked-by: Mike Turquette <mturquette@linaro.org>

Applied onto fixes branch.

Best regards,
Tomasz
