From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 21 May 2015 10:57:29 +0900
Subject: [PATCH] ARM: dts: Update video-phy node with syscon phandle for
 Exynos3250
In-Reply-To: <1426762587-24923-1-git-send-email-b.michalska@samsung.com>
References: <1426762587-24923-1-git-send-email-b.michalska@samsung.com>
Message-ID: <CAJKOXPfumy5a6A275ETy7vnztzE20qSuXD_i=ebY9Br47p93Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-19 19:56 GMT+09:00 Beata Michalska <b.michalska@samsung.com>:
> As a follow-up to recent changes to Exynos mipi video phy
> driver, introducing support for PMU regmap in commit
> e4b3d38088df6f3acd40 ("phy: exynos-video-mipi: Fix regression
> by adding support for PMU regmap") add a syscon phandle to
> video-phy node to bring back to life both MIPI DSI displays
> and MIPI CSIS-2 camera sensors on Exynos3250.
>
> Signed-off-by: Beata Michalska <b.michalska@samsung.com>

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Tested on Gear 2 (Exynos3250) board.

I'll queue it and send later to Kukjin.

Best regards,
Krzysztof
