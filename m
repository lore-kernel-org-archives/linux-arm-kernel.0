From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Feb 2017 17:48:33 +0000
Subject: [PATCH 1/2] dt-bindings: arm-ccn: Add bindings info for CCN-502
 compatible string
In-Reply-To: <1486759368-24067-2-git-send-email-velibor.markovski@broadcom.com>
References: <1486759368-24067-1-git-send-email-velibor.markovski@broadcom.com>
 <1486759368-24067-2-git-send-email-velibor.markovski@broadcom.com>
Message-ID: <20170214174833.GK23718@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 12:42:47PM -0800, Velibor Markovski wrote:
> Add CCN-502 to the list of supported devices by ARM CCN PMU driver.
> 
> Signed-off-by: Velibor Markovski <velibor.markovski@broadcom.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

I assume Pawel will take this along with the driver patch.

Thanks,
Mark.

> ---
>  Documentation/devicetree/bindings/arm/ccn.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ccn.txt b/Documentation/devicetree/bindings/arm/ccn.txt
> index b100d38..2980145 100644
> --- a/Documentation/devicetree/bindings/arm/ccn.txt
> +++ b/Documentation/devicetree/bindings/arm/ccn.txt
> @@ -3,6 +3,7 @@
>  Required properties:
>  
>  - compatible: (standard compatible string) should be one of:
> +	"arm,ccn-502"
>  	"arm,ccn-504"
>  	"arm,ccn-508"
>  
> -- 
> 1.9.1
> 
