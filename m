From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 12 Mar 2016 13:55:20 +0900
Subject: [PATCH 1/5] hwrng: exynos - Hide PM functions with __maybe_unused
In-Reply-To: <1457682562-21219-1-git-send-email-k.kozlowski@samsung.com>
References: <1457682562-21219-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CAJKOXPd00gaPwAmXL7+_nX16QD-K9zoHcf0Y3oGx6UEh0USXOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-03-11 16:49 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> Replace ifdef with __maybe_unused to silence compiler warning on when
> SUSPEND=n and PM=y:
>
> drivers/char/hw_random/exynos-rng.c:166:12: warning: ?exynos_rng_suspend? defined but not used [-Wunused-function]
>  static int exynos_rng_suspend(struct device *dev)
>             ^
> drivers/char/hw_random/exynos-rng.c:171:12: warning: ?exynos_rng_resume? defined but not used [-Wunused-function]
>  static int exynos_rng_resume(struct device *dev)
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/char/hw_random/exynos-rng.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>

Patch can be dropped, Arnd sent the same some days before.

Best regards,
Krzysztof
