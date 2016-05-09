From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 9 May 2016 17:25:14 -0400
Subject: [PATCH v2 13/22] ARM: dts: exynos: Move common nodes to
 exynos5.dtsi
In-Reply-To: <1462734367-5619-14-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
 <1462734367-5619-14-git-send-email-krzk@kernel.org>
Message-ID: <1cee1acf-fb07-9a7f-5d18-b4824a10f5a2@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/08/2016 03:05 PM, Krzysztof Kozlowski wrote:
> Exynos5420 and Exynos5250 share some nodes: the PWM and syscon
> (sysreg_system_controller). Move them to parent DTSI to avoid
> duplication.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

I see that the i2c_[0-3] nodes are also the same in both DTSI. Do you
think that makes sense to also move those to exynos5.dtsi as well?

In any case that can be made as a follow-up, so:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
