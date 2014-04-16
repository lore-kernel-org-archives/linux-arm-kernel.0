From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Apr 2014 15:51:29 +0200
Subject: [PATCH 5/6] ARM: EXYNOS: Enable multi-platform build support
In-Reply-To: <1397554134-11827-6-git-send-email-sachin.kamat@linaro.org>
References: <1397554134-11827-1-git-send-email-sachin.kamat@linaro.org>
 <1397554134-11827-6-git-send-email-sachin.kamat@linaro.org>
Message-ID: <534E8AE1.4010402@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sachin,

On 15.04.2014 11:28, Sachin Kamat wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> This makes it possible to enable the exynos platform as part of a
> multiplatform kernel, in addition to keeping the single-platform
> Exynos support.
> sparsemem is currently not supported in multiplatform.

Is this still true as of today?

Otherwise looks fine.

Best regards,
Tomasz
