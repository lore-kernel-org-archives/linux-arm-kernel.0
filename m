From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 22 Jun 2016 10:18:18 +0100
Subject: [PATCH] coresight: document binding acronyms
In-Reply-To: <1466534486-22422-1-git-send-email-mathieu.poirier@linaro.org>
References: <1466534486-22422-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <576A57DA.8090309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/06/16 19:41, Mathieu Poirier wrote:
> It can be hard for people not familiar with the CoreSight IP blocks
> to make sense of the acronyms found in the current bindings.  As such
> this patch expands each acronym in the hope of providing a better
> description of the IP block they represent.
>

Thanks for adding these info so quickly. Just a minor nit below.

> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   .../devicetree/bindings/arm/coresight.txt          | 32 ++++++++++++++++------
>   1 file changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index 93147c0c8a0e..c73a7f773998 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -12,14 +12,30 @@ its hardware characteristcs.
>
>   	* compatible: These have to be supplemented with "arm,primecell" as
>   	  drivers are using the AMBA bus interface.  Possible values include:
> -		- "arm,coresight-etb10", "arm,primecell";
> -		- "arm,coresight-tpiu", "arm,primecell";
> -		- "arm,coresight-tmc", "arm,primecell";
> -		- "arm,coresight-funnel", "arm,primecell";
> -		- "arm,coresight-etm3x", "arm,primecell";
> -		- "arm,coresight-etm4x", "arm,primecell";
> -		- "qcom,coresight-replicator1x", "arm,primecell";
> -		- "arm,coresight-stm", "arm,primecell"; [1]
> +		- Embedded Trace Buffer (version 1.0):
> +			"arm,coresight-etb10", "arm,primecell";
> +
> +		- Trace Port Interface Unit:
> +			"arm,coresight-tpiu", "arm,primecell";
> +
> +		- Trace Memory Controller (ETB, ETF, ETR):

Only ETB is expanded in the list, does it make sense to expand ETF and
ETR too ?

-- 
Regards,
Sudeep
