From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 8 Sep 2016 13:04:58 +0200
Subject: [PATCH v2 1/7] clocksource: exynos_mct: Add the support for ARM64
In-Reply-To: <1472046551-703-2-git-send-email-cw00.choi@samsung.com>
References: <1472046551-703-1-git-send-email-cw00.choi@samsung.com>
 <1472046551-703-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <562e232f-7e69-6d54-e49d-36042d166800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/08/2016 15:49, Chanwoo Choi wrote:
> This patch adds the support for ARM 64bit. The delay_timer is only supported
> on ARM 32bit.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---

I don't really like #ifdef in the code itself but I suppose there is no
much choice.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
