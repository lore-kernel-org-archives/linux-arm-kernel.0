From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 9 Oct 2018 10:11:49 +0200
Subject: [PATCH 1/7] clocksource: exynos_mct: Remove dead code
In-Reply-To: <20181008125009.3721-2-m.szyprowski@samsung.com>
References: <CGME20181008125046eucas1p1e0304c8c22a4ac128a8e507c86442a37@eucas1p1.samsung.com>
 <20181008125009.3721-1-m.szyprowski@samsung.com>
 <20181008125009.3721-2-m.szyprowski@samsung.com>
Message-ID: <CAJKOXPfMCy_tiZ7x6gn6m4BnER=niONxJCwvMTTZwcEHK--5fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Oct 2018 at 14:50, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Exynos Multi-Core Timer driver is used only on device-tree based
> systems, so remove non-dt related code.

You can also mention that in case of !CONFIG_OF the code is anyway
equal because of_irq_count() has a stub returning 0.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
