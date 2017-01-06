From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 6 Jan 2017 09:09:21 -0300
Subject: [PATCH v4 1/5] arm64: dts: exynos5433: TM2/E: Fix wrong values
 foe ldo23 and ldo25
In-Reply-To: <20170106114114.19321-2-andi.shyti@samsung.com>
References: <20170106114114.19321-1-andi.shyti@samsung.com>
 <CGME20170106114120epcas5p21ed16e8f71152245f12fd00a8d73df0a@epcas5p2.samsung.com>
 <20170106114114.19321-2-andi.shyti@samsung.com>
Message-ID: <5f0740a0-8799-f414-38bc-d40911613ae3@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andi,

On 01/06/2017 08:41 AM, Andi Shyti wrote:
> From: Chanwoo Choi <cw00.choi@samsung.com>
> 
> This patch fixes wrong values assigned to ldo23 and ldo25 on both TM2 and TM2E.
> 
> Fixes: 01e5d2352152 ("arm64: dts: exynos: Add dts file for Exynos5433-based TM2 board")
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---

I don't have the schematics to check, but the patch looks good to me
besides the "regulator-always-off" property as Krzysztof mentioned.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
