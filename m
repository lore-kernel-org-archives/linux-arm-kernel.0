From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 9 May 2016 16:24:51 -0400
Subject: [PATCH v2 06/22] ARM: dts: exynos: Remove old fixed-clock
 provider on SMDK5410
In-Reply-To: <1462734367-5619-7-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
 <1462734367-5619-7-git-send-email-krzk@kernel.org>
Message-ID: <723d088c-ada7-a18f-87a2-e7caaf2c56fd@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/08/2016 03:05 PM, Krzysztof Kozlowski wrote:
> All "fin_pll" clock users are switched to the new one, provided by

s/are switched/were switched

> Exynos5410 clock driver. Remove old DT node.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
