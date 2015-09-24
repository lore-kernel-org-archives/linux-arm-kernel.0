From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 24 Sep 2015 18:21:55 +0100
Subject: [PATCH v3 2/4] Documentation: bindings: mfd: cros ec: document
 vbc EC property
In-Reply-To: <1442842703-5309-3-git-send-email-emilio.lopez@collabora.co.uk>
References: <1442842703-5309-1-git-send-email-emilio.lopez@collabora.co.uk>
 <1442842703-5309-3-git-send-email-emilio.lopez@collabora.co.uk>
Message-ID: <20150924172155.GC27197@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Sep 2015, Emilio L?pez wrote:

> Some EC implementations include a small nvram space used to store
> verified boot context data. This boolean property lets us indicate
> whether this space is available or not on a specific EC implementation.
> 
> Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>
> ---
> 
> Patch is new in v3, split from 3/4
> 
>  Documentation/devicetree/bindings/mfd/cros-ec.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/cros-ec.txt b/Documentation/devicetree/bindings/mfd/cros-ec.txt
> index 1777916..136e0c2 100644
> --- a/Documentation/devicetree/bindings/mfd/cros-ec.txt
> +++ b/Documentation/devicetree/bindings/mfd/cros-ec.txt
> @@ -34,6 +34,10 @@ Required properties (LPC):
>  - compatible: "google,cros-ec-lpc"
>  - reg: List of (IO address, size) pairs defining the interface uses
>  
> +Optional properties (all):
> +- google,has-vbc-nvram: Some implementations of the EC include a small
> +  nvram space used to store verified boot context data. This boolean flag
> +  is used to specify whether this nvram is present or not.
>  
>  Example for I2C:
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
