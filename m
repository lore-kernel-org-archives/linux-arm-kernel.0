From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 16 Sep 2015 07:35:52 +0900
Subject: [PATCH v3 1/2] ARM: dts: Split audio configuration to
 separateexynos5422-odroidxu3-audio
In-Reply-To: <1442191669-3366-1-git-send-email-k.kozlowski@samsung.com>
References: <1442191669-3366-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <55F89D48.900@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/15 09:47, Krzysztof Kozlowski wrote:
> The Odroid XU4 board does not have audio codec so before adding DTS for
> new board split the audio codec to separate DTSI file. Include the audio codec
> DTSI in Odroid XU3 and XU3-Lite boards.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
Applied 1-2.

Thanks,
Kukjin
