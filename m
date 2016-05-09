From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 9 May 2016 17:29:48 -0400
Subject: [PATCH v2 15/22] ARM: dts: exynos: Use phandle to get parent node
 in exynos5250-snow
In-Reply-To: <1462734367-5619-16-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
 <1462734367-5619-16-git-send-email-krzk@kernel.org>
Message-ID: <a978eba1-5dc9-0b20-d131-b180047cc143@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/08/2016 03:06 PM, Krzysztof Kozlowski wrote:
> The i2c-arbitrator node in exynos5250-snow-common used absolute path to
> reference other node (the i2c parent). Use phandle instead, because the
> depth of the other node may be changed (like moving it under 'soc'
> node).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
