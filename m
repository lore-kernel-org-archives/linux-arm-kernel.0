From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 11 May 2015 16:05:44 +0200
Subject: [PATCH 1/3] clocksource: exynos_mct: Change exynos4_mct_tick_clear
 return type to void
In-Reply-To: <1430368973-23786-1-git-send-email-k.kozlowski@samsung.com>
References: <1430368973-23786-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5550B738.60509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2015 06:42 AM, Krzysztof Kozlowski wrote:
> Return value of exynos4_mct_tick_clear() was never checked so it can
> be safely changed to void.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Applied to my tree for 4.2

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
