From: robh@kernel.org (Rob Herring)
Date: Sun, 17 Jul 2016 15:26:04 -0500
Subject: [PATCH v2] media: Doc add missing documentation for
 samsung,exynos4212-jpeg
In-Reply-To: <1468620627-9750-1-git-send-email-shuahkh@osg.samsung.com>
References: <1468620627-9750-1-git-send-email-shuahkh@osg.samsung.com>
Message-ID: <20160717202522.GA8777@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 04:10:27PM -0600, Shuah Khan wrote:
> Add add missing documentation for samsung,exynos4212-jpeg codec,
> reorder entries to improve readability and make it easier to add
> new entries.
> 
> samsung,exynos4212-jpeg and samsung,exynos4210-jpeg are identical,
> hence add samsung,exynos4212-jpeg as deprecated in the documentation.
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
> 
> Changes since v1:
> - Added samsung,exynos4212-jpeg as deprecated
> 
>  Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt b/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt
> index 38941db..c5399e7 100644
> --- a/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt
> +++ b/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt
> @@ -3,9 +3,11 @@ Samsung S5P/EXYNOS SoC series JPEG codec
>  Required properties:
>  
>  - compatible	: should be one of:
> -		  "samsung,s5pv210-jpeg", "samsung,exynos4210-jpeg",
> -		  "samsung,exynos3250-jpeg", "samsung,exynos5420-jpeg",
> +		  "samsung,s5pv210-jpeg", "samsung,exynos3250-jpeg",
> +		  "samsung,exynos4210-jpeg", "samsung,exynos5420-jpeg",
>  		  "samsung,exynos5433-jpeg";
> +
> +		  (Deprecated: "samsung,exynos4212-jpeg").

Since you are reformatting, one compatible per line (unless multiple 
apply) is preferred.

>  - reg		: address and length of the JPEG codec IP register set;
>  - interrupts	: specifies the JPEG codec IP interrupt;
>  - clock-names   : should contain:
> -- 
> 2.7.4
> 
