From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Fri, 15 Jul 2016 08:25:10 +0200
Subject: [PATCH] media: Doc add missing documentation for
 samsung,exynos4212-jpeg
In-Reply-To: <1468526499-8840-1-git-send-email-shuahkh@osg.samsung.com>
References: <1468526499-8840-1-git-send-email-shuahkh@osg.samsung.com>
Message-ID: <578881C6.8040701@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shuah,

On 07/14/2016 10:01 PM, Shuah Khan wrote:
> Add add missing documentation for samsung,exynos4212-jpeg codec,
> reorder entries to improve readability and make it easier to add
> new entries.
>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>   Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt b/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt
> index 38941db..093614c 100644
> --- a/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt
> +++ b/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt
> @@ -3,9 +3,9 @@ Samsung S5P/EXYNOS SoC series JPEG codec
>   Required properties:
>
>   - compatible	: should be one of:
> -		  "samsung,s5pv210-jpeg", "samsung,exynos4210-jpeg",
> -		  "samsung,exynos3250-jpeg", "samsung,exynos5420-jpeg",
> -		  "samsung,exynos5433-jpeg";
> +		  "samsung,s5pv210-jpeg", "samsung,exynos3250-jpeg",
> +		  "samsung,exynos4210-jpeg", "samsung,exynos4212-jpeg",
> +		  "samsung,exynos5420-jpeg", "samsung,exynos5433-jpeg";
>   - reg		: address and length of the JPEG codec IP register set;
>   - interrupts	: specifies the JPEG codec IP interrupt;
>   - clock-names   : should contain:
>

Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>

-- 
Best regards,
Jacek Anaszewski
