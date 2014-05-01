From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 02 May 2014 01:32:37 +0200
Subject: [PATCH 1/2] of: add bq and radxa vendor prefixes
In-Reply-To: <1398973835-26303-1-git-send-email-b.galvani@gmail.com>
References: <1398973835-26303-1-git-send-email-b.galvani@gmail.com>
Message-ID: <2225372.rvnmuAdhHE@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Beniamino,

Am Donnerstag, 1. Mai 2014, 21:50:34 schrieb Beniamino Galvani:
> Add new vendor prefixes for:
> 
>     * bq, a company that sells multimedia devices and 3D printers

bq is actually only a brandname. The company itself is "Mundo Reader S.L.".
I'm not sure what the actual policy is concerning the vendor prefix, i.e. if it 
should use the visible brand name or the actual company name.

I.e. another possibility would be to add the vendor prefix
	mundoreader	Mundo Reader S.L.
and name the currie
	mundoreader,bq-curie2


Heiko

>     * Radxa, manufacturer of ARM boards
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> b/Documentation/devicetree/bindings/vendor-prefixes.txt index
> abc3080..6f8177c 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -21,6 +21,7 @@ atmel	Atmel Corporation
>  auo	AU Optronics Corporation
>  avago	Avago Technologies
>  bosch	Bosch Sensortec GmbH
> +bq	bq
>  brcm	Broadcom Corporation
>  buffalo	Buffalo, Inc.
>  calxeda	Calxeda
> @@ -98,6 +99,7 @@ powervr	PowerVR (deprecated, use img)
>  qca	Qualcomm Atheros, Inc.
>  qcom	Qualcomm Technologies, Inc
>  qnap	QNAP Systems, Inc.
> +radxa	Radxa
>  raidsonic	RaidSonic Technology GmbH
>  ralink	Mediatek/Ralink Technology Corp.
>  ramtron	Ramtron International
