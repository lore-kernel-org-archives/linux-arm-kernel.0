From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 13 Oct 2015 10:24:34 +0200
Subject: [PATCH 1/4] ARM: exynos_defconfig: Enable Maxim 8997 family
 drivers
In-Reply-To: <1444699628-3774-1-git-send-email-k.kozlowski@samsung.com>
References: <1444699628-3774-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <561CBFC2.5080101@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 10/13/2015 03:27 AM, Krzysztof Kozlowski wrote:
> Enable support for Maxim 8997 Multi Functional Device present on Trats and
> Origen boards by toggling on drivers: charger, haptic motor,
> LED, RTC and extcon.
> 
> This allows to test and usage of these boards with exynos config.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
