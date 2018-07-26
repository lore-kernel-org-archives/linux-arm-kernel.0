From: sboyd@kernel.org (Stephen Boyd)
Date: Thu, 26 Jul 2018 08:17:03 -0700
Subject: [PATCH] clk: samsung: Remove unused mout_user_aclk400_mcuisp_p4x12
 variable
In-Reply-To: <20180718195620.5331-1-krzk@kernel.org>
References: <20180718195620.5331-1-krzk@kernel.org>
Message-ID: <153261822377.48062.13389862802943338719@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Krzysztof Kozlowski (2018-07-18 12:56:20)
> Remove unused 'mout_user_aclk400_mcuisp_p4x12' variable to fix GCC warning:
> 
>     drivers/clk/samsung/clk-exynos4412-isp.c:40:27: warning:
>         'mout_user_aclk400_mcuisp_p4x12' defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Applied to clk-next
