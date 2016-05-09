From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 9 May 2016 18:02:51 -0400
Subject: [PATCH v2 22/22] ARM: dts: exynos: Add initial support for Odroid
 XU board
In-Reply-To: <1462734367-5619-23-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
 <1462734367-5619-23-git-send-email-krzk@kernel.org>
Message-ID: <cbcb5657-8825-83cf-688f-d565ac7ecbab@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/08/2016 03:06 PM, Krzysztof Kozlowski wrote:
> The Hardkernel's Odroid XU board was first design with big.LITTLE SoC
> from Samsung: the Exynos5410. Comparing now to more popular Odroid XU3
> the differences are:
> 1. Exynos5410 instead of 5422,
> 2. DisplayPort,
> 3. Main PMIC: Maxim 77802 instead of S2MPS11,
> 4. USB3503+LAN9730 instead of integrated LAN9514,
> 5. eMMC 4.5 instead of eMMC 5.0,
> 
> This patch adds initial support for the XU board with working basic
> functions, eMMC/SD and USB (including attached ethernet adapter).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

This DTS has some TODO's, FIXME's and commented input supplies. Probably
this patch should had been an RFC? or you should mention about these in
the commit message to understand why are there.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
