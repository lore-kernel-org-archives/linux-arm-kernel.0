From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 10 Nov 2013 18:14:37 +0100
Subject: [PATCH 3/3] clk: exynos5250: register APLL rate table
In-Reply-To: <1383905648-23733-3-git-send-email-sachin.kamat@linaro.org>
References: <1383905648-23733-1-git-send-email-sachin.kamat@linaro.org>
 <1383905648-23733-3-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1713728.JoffI8rva3@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sachin, Andrew,

On Friday 08 of November 2013 15:44:08 Sachin Kamat wrote:
> From: Andrew Bresticker <abrestic@chromium.org>
> 
> Register the APLL rate table so that we can set the APLL rate from
> the cpufreq driver.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/clk/samsung/clk-exynos5250.c |   25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)

You know that you still need to fix the cpufreq driver to use these,
don't you? Anyway:

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
