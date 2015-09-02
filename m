From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 2 Sep 2015 09:52:41 +0200
Subject: [PATCH v2 1/2] ARM: dts: Split audio configuration to separate
 exynos5422-odroidxu3-audio
In-Reply-To: <1441157405-22123-1-git-send-email-k.kozlowski@samsung.com>
References: <1441157405-22123-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <55E6AAC9.2010804@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 09/02/2015 03:30 AM, Krzysztof Kozlowski wrote:
> The Odroid XU4 board does not have audio codec so before adding DTS for
> new board split the audio codec to separate DTSI file. Include the audio codec
> DTSI in Odroid XU3 and XU3-Lite boards.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
