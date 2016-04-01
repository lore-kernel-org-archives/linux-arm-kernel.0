From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 1 Apr 2016 13:46:10 -0400
Subject: [PATCH 10/11] ARM: dts: exynos: Fix DTC unit name warnings in
 Exynos5440
In-Reply-To: <1459493874-2366-10-git-send-email-k.kozlowski@samsung.com>
References: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
 <1459493874-2366-10-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56FEB3E2.3050607@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 04/01/2016 02:57 AM, Krzysztof Kozlowski wrote:
> Fix following DTC warnings in Exynos5440 boards:
> 
> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): Node /pinctrl has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): Node /rtc has a reg or ranges property, but no unit name
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
