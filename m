From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 26 Aug 2016 18:02:19 +0200
Subject: [PATCH v2 1/7] clocksource: exynos_mct: Add the support for ARM64
In-Reply-To: <1472046551-703-2-git-send-email-cw00.choi@samsung.com>
References: <1472046551-703-1-git-send-email-cw00.choi@samsung.com>
 <1472046551-703-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <20160826160219.GA15511@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 10:49:05PM +0900, Chanwoo Choi wrote:
> This patch adds the support for ARM 64bit. The delay_timer is only supported
> on ARM 32bit.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/clocksource/Kconfig      | 2 +-
>  drivers/clocksource/exynos_mct.c | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
