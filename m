From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 02 Jun 2015 22:02:34 +0900
Subject: [PATCH v4 5/5] ARM: dts: Add LEDs to exynos5410-odroidxu
In-Reply-To: <1426456834-6308-6-git-send-email-afaerber@suse.de>
References: <1426456834-6308-1-git-send-email-afaerber@suse.de>
 <1426456834-6308-6-git-send-email-afaerber@suse.de>
Message-ID: <556DA96A.90800@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 16.03.2015 o 07:00, Andreas F?rber pisze:
> Signed-off-by: Hakjoo Kim <ruppi.kim@hardkernel.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2 -> v3: Unchanged
>  
>  v1 -> v2:
>  * Filled in Sob from Hakjoo Kim
>  
>  arch/arm/boot/dts/exynos5410-odroidxu.dts | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

What is the rationale behind doing this in separate patch, not as part
of 2/5? You can just add new board DTS with all of its features at once,
but maybe I am missing something?

Best regards,
Krzysztof
