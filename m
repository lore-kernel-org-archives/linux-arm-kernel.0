From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 9 May 2016 17:55:16 -0400
Subject: [PATCH v2 21/22] ARM: dts: exynos: Add USB to Exynos5410
In-Reply-To: <1462734367-5619-22-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
 <1462734367-5619-22-git-send-email-krzk@kernel.org>
Message-ID: <419e078b-a0c5-e7a6-0bea-9961147380d5@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/08/2016 03:06 PM, Krzysztof Kozlowski wrote:
> Move USB 3.0 DWC and 2.0 EHCI/OHCI nodes from exynos5420.dtsi to
> exynos54xx.dtsi common for entire family. For Exynos542x/5800 this
> should not have functional impact but for Exynos5410 this effectively
> adds USB support.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
