From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 2 Feb 2016 15:56:09 -0300
Subject: [PATCH] drivers: soc: samsung: Enable COMPILE_TEST
In-Reply-To: <1454396777-20034-1-git-send-email-k.kozlowski@samsung.com>
References: <1454396777-20034-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56B0FBC9.1020308@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 02/02/2016 04:06 AM, Krzysztof Kozlowski wrote:
> Get some build coverage of Exynos SROM controller and PMU drivers. The
> PMU driver depends on asm/cputype.h so its compilation is limited to ARM
> architectures.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
