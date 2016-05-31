From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 31 May 2016 15:37:28 -0400
Subject: [PATCH 6/6] ARM: dts: exynos: No need to enable TMU nodes on
 Odroid XU3 family
In-Reply-To: <1464719945-3417-6-git-send-email-krzk@kernel.org>
References: <1464719945-3417-1-git-send-email-krzk@kernel.org>
 <1464719945-3417-6-git-send-email-krzk@kernel.org>
Message-ID: <c3222e0a-51a9-a93f-97e4-9a12e17167de@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/31/2016 02:39 PM, Krzysztof Kozlowski wrote:
> The thermal nodes are not disabled in exynos5420.dtsi so there is no
> need to manually enable them on Odroid XU3/XU3-Lite/XU4 boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
