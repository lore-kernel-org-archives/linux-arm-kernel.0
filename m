From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 Jan 2017 11:03:48 +0000
Subject: [V3 3/3] dt-bindings: Add a support cpu type for cortex-a73
In-Reply-To: <1485248249-117383-3-git-send-email-puck.chen@hisilicon.com>
References: <1485248249-117383-1-git-send-email-puck.chen@hisilicon.com>
 <1485248249-117383-3-git-send-email-puck.chen@hisilicon.com>
Message-ID: <20170124110347.GC6277@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 04:57:29PM +0800, Chen Feng wrote:
> Add arm cpu type cortex-a73
> 
> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index a1bcfee..d748774 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -158,6 +158,7 @@ nodes to be present and contain the properties described below.
>  			    "arm,cortex-a53"
>  			    "arm,cortex-a57"
>  			    "arm,cortex-a72"
> +			    "arm,cortex-a73"
>  			    "arm,cortex-m0"
>  			    "arm,cortex-m0+"
>  			    "arm,cortex-m1"
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
