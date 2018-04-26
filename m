From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 26 Apr 2018 10:15:21 +0900
Subject: [RFC 07/10] pinctrl: samsung: Remove support for Exynos5440
In-Reply-To: <20180424203239.21885-8-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
 <CGME20180424203539epcas2p4e099df5797adb9a49c0d49bbfc829543@epcas2p4.samsung.com>
 <20180424203239.21885-8-krzk@kernel.org>
Message-ID: <5AE12829.4090607@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2018? 04? 25? 05:32, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/pinctrl/samsung/Kconfig              |   10 +-
>  drivers/pinctrl/samsung/Makefile             |    1 -
>  drivers/pinctrl/samsung/pinctrl-exynos5440.c | 1005 --------------------------
>  3 files changed, 2 insertions(+), 1014 deletions(-)
>  delete mode 100644 drivers/pinctrl/samsung/pinctrl-exynos5440.c

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
