From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jul 2015 17:22:00 +0900
Subject: [PATCH v2 3/7] cpufreq-dt: add turbo modes support
In-Reply-To: <1436456621-29839-4-git-send-email-b.zolnierkie@samsung.com>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <559F80A8.9050706@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.07.2015 00:43, Bartlomiej Zolnierkiewicz wrote:
> Add turbo modes (from opp-v2 bindings) support using
> existing cpufreq 'boost' mode infrastructure:
> - add boost_supported field to struct cpufreq_dt_platform_data
> - set dt_cpufreq_driver.boost_supported in dt_cpufreq_probe()
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 7 ++++++-
>  include/linux/cpufreq-dt.h   | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)

Looks fine,
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
