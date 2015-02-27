From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 27 Feb 2015 20:15:17 +0000
Subject: [PATCH 1/3] Documentation: dts: Update compatible field
 description for APM X-Gene
In-Reply-To: <1425067710-14879-2-git-send-email-isubramanian@apm.com>
References: <1425067710-14879-1-git-send-email-isubramanian@apm.com>
 <1425067710-14879-2-git-send-email-isubramanian@apm.com>
Message-ID: <20150227201516.GA30683@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 08:08:28PM +0000, Iyappan Subramanian wrote:
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
> Signed-off-by: Keyur Chudgar <kchudgar@apm.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> ---
>  Documentation/devicetree/bindings/net/apm-xgene-enet.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
> index cfcc527..5355996 100644
> --- a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
> +++ b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
> @@ -4,7 +4,8 @@ Ethernet nodes are defined to describe on-chip ethernet interfaces in
>  APM X-Gene SoC.
>  
>  Required properties for all the ethernet interfaces:
> -- compatible: Should be "apm,xgene-enet"
> +- compatible: Should be "apm,xgene-enet", "apm,xgene1-sgenet" or
> +  "apm,xgene1-xgenet"

Please format this as a list. It'll be easier to read, and you can add
more later.

What are the diffences between these variants?

Mark.

>  - reg: Address and length of the register set for the device. It contains the
>    information of registers in the same order as described by reg-names
>  - reg-names: Should contain the register set names
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
