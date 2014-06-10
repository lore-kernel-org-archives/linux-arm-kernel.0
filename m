From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Tue, 10 Jun 2014 22:39:21 +0300
Subject: [PATCH] mmc: sdhci-msm: Fix fallout from sdhci refactoring
In-Reply-To: <1402424839-25514-1-git-send-email-sboyd@codeaurora.org>
References: <1402424839-25514-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <53975EE9.8010202@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.06.14, 21:27, Stephen Boyd wrote:
> The sdhci core was refactored recently and some of those
> refactorings required changes in every sdhci platform driver.
> Those updates happened around the same time as when the msm
> driver was merged so the refactorings missed the msm driver.
> Hook in the basic library functions so that we can boot apq8074
> dragonboards again instead of crashing when we try to jump to
> NULL function pointers.
> 
> Reported-by: Kevin Hilman <khilman@linaro.org>
> Cc: Georgi Djakov <gdjakov@mm-sol.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Reviewed-by: Georgi Djakov <gdjakov@mm-sol.com>
