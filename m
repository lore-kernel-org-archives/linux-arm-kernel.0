From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 5 Jun 2017 09:14:51 +0100
Subject: [PATCH v3 1/6] dt-bindings: mfd: hi6421: Add hi6421v530
 compatible string
In-Reply-To: <20170602105156.11351-2-guodong.xu@linaro.org>
References: <20170602105156.11351-1-guodong.xu@linaro.org>
 <20170602105156.11351-2-guodong.xu@linaro.org>
Message-ID: <20170605081451.d7pd6r7aeza54pgv@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 02 Jun 2017, Guodong Xu wrote:

> Add compatible string for HiSilicon Hi6421v530 PMIC.
> 
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/hi6421.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
  
> diff --git a/Documentation/devicetree/bindings/mfd/hi6421.txt b/Documentation/devicetree/bindings/mfd/hi6421.txt
> index 0d5a446..22da96d 100644
> --- a/Documentation/devicetree/bindings/mfd/hi6421.txt
> +++ b/Documentation/devicetree/bindings/mfd/hi6421.txt
> @@ -1,7 +1,9 @@
>  * HI6421 Multi-Functional Device (MFD), by HiSilicon Ltd.
>  
>  Required parent device properties:
> -- compatible	: contains "hisilicon,hi6421-pmic";
> +- compatible    : One of the following chip-specific strings:
> +	"hisilicon,hi6421-pmic";
> +	"hisilicon,hi6421v530-pmic";
>  - reg		: register range space of hi6421;
>  
>  Supported Hi6421 sub-devices include:

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
