From: oss@buserror.net (Scott Wood)
Date: Fri, 26 Aug 2016 17:37:50 -0500
Subject: [PATCH 07/10] dt-bindings: thermal: Update bindings for LS1012A
In-Reply-To: <1472207269-18499-7-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1472207269-18499-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <1472207269-18499-7-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <1472251070.13245.10.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-08-26 at 15:57 +0530, Bhaskar Upadhaya wrote:
> Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
> ---
> ?Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> index 66223d5..8e2b211 100644
> --- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> @@ -1,7 +1,7 @@
> ?* Thermal Monitoring Unit (TMU) on Freescale QorIQ SoCs
> ?
> ?Required properties:
> -- compatible : Must include "fsl,qoriq-tmu". The version of the device is
> +- compatible :"fsl,qoriq-tmu", "fsl,ls1012a-tmu". The version of the device
> is
> ?	determined by the TMU IP Block Revision Register (IPBRR0) at
> ?	offset 0x0BF8.
> ?	Table of correspondences between IPBRR0 values and example??chips:

Why is this needed given that the block has a version register?

-Scott
