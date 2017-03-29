From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 29 Mar 2017 12:25:44 +0100
Subject: [PATCH v2 8/8] bus: brcmstb_gisb: update to support new revision
In-Reply-To: <20170328213431.10904-9-opendmb@gmail.com>
References: <20170328213431.10904-1-opendmb@gmail.com>
 <20170328213431.10904-9-opendmb@gmail.com>
Message-ID: <20170329112544.GF23442@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 02:34:31PM -0700, Doug Berger wrote:
> The 7278 introduces a new version of this core.  This
> commit adds support for that revision.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>  Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt |  3 ++-
>  drivers/bus/brcmstb_gisb.c                              | 10 ++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
> index 1eceefb20f01..8a6c3c2e58fe 100644
> --- a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
> +++ b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
> @@ -3,7 +3,8 @@ Broadcom GISB bus Arbiter controller
>  Required properties:
>  
>  - compatible:
> -    "brcm,gisb-arb" or "brcm,bcm7445-gisb-arb" for 28nm chips
> +    "brcm,bcm7278-gisb-arb" for V7 28nm chips
> +    "brcm,gisb-arb" or "brcm,bcm7445-gisb-arb" for other 28nm chips
>      "brcm,bcm7435-gisb-arb" for newer 40nm chips
>      "brcm,bcm7400-gisb-arb" for older 40nm chips and all 65nm chips
>      "brcm,bcm7038-gisb-arb" for 130nm chips

For the binding:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
