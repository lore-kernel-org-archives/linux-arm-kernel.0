From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Jun 2014 11:44:05 +0100
Subject: [PATCH 2/5] Documentation: bindings: document the Marvell Berlin
 enable-method
In-Reply-To: <1401700866-24804-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1401700866-24804-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401700866-24804-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140602104405.GB13573@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 02, 2014 at 10:21:03AM +0100, Antoine T?nart wrote:
> The SMP support for Marvell Berlin SoCs introduce a new enable-method.
> Document it.
> 
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 333f4aea3029..50ec9ae6de28 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -185,6 +185,7 @@ nodes to be present and contain the properties described below.
>  			    "qcom,gcc-msm8660"
>  			    "qcom,kpss-acc-v1"
>  			    "qcom,kpss-acc-v2"
> +			    "marvell,berlin-smp"

And what does this mean?

The existing bindings are ambiguous enough. It would be nice to have a
proper document describing the method, as Alex Elder is trying to sort
out for the existing bindings.

Cheers,
Mark.
