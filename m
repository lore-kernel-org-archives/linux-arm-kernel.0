From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 11 May 2015 16:06:25 +0200
Subject: [PATCH 3/3] clocksource: exynos_mct: Remove old platform
 mct_init()
In-Reply-To: <1430368973-23786-3-git-send-email-k.kozlowski@samsung.com>
References: <1430368973-23786-1-git-send-email-k.kozlowski@samsung.com>
 <1430368973-23786-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5550B761.9080208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2015 06:42 AM, Krzysztof Kozlowski wrote:
> Since commit 228e3023eb04 ("Merge tag 'mct-exynos-for-v3.10' of ...") the
> mct_init() was superseded by mct_init_dt() and is not referenced
> anywhere. Remove it.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Applied to my tree for 4.2

Thanks !

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
