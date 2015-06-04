From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 04 Jun 2015 11:00:58 +0900
Subject: [PATCH] drivers/cpufreq: include <module.h> for modular
 exynos-cpufreq.c code
In-Reply-To: <1433366298-30016-1-git-send-email-paul.gortmaker@windriver.com>
References: <1430444867-22342-1-git-send-email-paul.gortmaker@windriver.com>
 <1433366298-30016-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <556FB15A.8010409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.06.2015 06:18, Paul Gortmaker wrote:
> This file is built off of a tristate Kconfig option ("ARM_EXYNOS_CPUFREQ")
> and also contains modular function calls so it should explicitly include
> module.h to avoid compile breakage during pending header shuffles.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: linux-pm at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
