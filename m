From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 1 Apr 2016 13:27:24 -0400
Subject: [PATCH 08/11] ARM: dts: exynos: Fix DTC unit name warnings in
 Peach Pit
In-Reply-To: <1459493874-2366-8-git-send-email-k.kozlowski@samsung.com>
References: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
 <1459493874-2366-8-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56FEAF7C.9000502@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 04/01/2016 02:57 AM, Krzysztof Kozlowski wrote:
> Fix following DTC warnings in Exynos5420 Peach Pit:
> 
> Warning (unit_address_vs_reg): Node /dp-controller at 145B0000/ports/port at 0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /i2c at 12CD0000/lvds-bridge at 48/ports/port at 0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /i2c at 12CD0000/lvds-bridge at 48/ports/port at 1 has a unit name, but no reg property
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
