From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 16 Jan 2017 12:56:08 +0900
Subject: [PATCH 3/4] pinctrl: samsung: Remove support for Exynos4415 (SoC
 not supported anymore)
In-Reply-To: <20170114123642.15581-4-krzk@kernel.org>
References: <20170114123642.15581-1-krzk@kernel.org>
 <CGME20170114123733epcas4p20d5ea05c5d705528138ebdefc56be69a@epcas4p2.samsung.com>
 <20170114123642.15581-4-krzk@kernel.org>
Message-ID: <587C4458.7020804@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017? 01? 14? 21:36, Krzysztof Kozlowski wrote:
> Support for Exynos4415 is going away because there are no internal nor
> external users.
> 
> Since commit 46dcf0ff0de3 ("ARM: dts: exynos: Remove exynos4415.dtsi"),
> the platform cannot be instantiated so remove also the drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos.c  | 75 -------------------------------
>  drivers/pinctrl/samsung/pinctrl-samsung.c |  2 -
>  drivers/pinctrl/samsung/pinctrl-samsung.h |  1 -
>  3 files changed, 78 deletions(-)

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]

-- 
Best Regards,
Chanwoo Choi
S/W Center, Samsung Electronics
