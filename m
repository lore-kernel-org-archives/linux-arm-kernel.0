From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 16 May 2014 12:09:04 +0200
Subject: [PATCH v2 1/2] of: add mundoreader and radxa vendor prefixes
In-Reply-To: <1399396211-25353-1-git-send-email-b.galvani@gmail.com>
References: <1399396211-25353-1-git-send-email-b.galvani@gmail.com>
Message-ID: <2536935.asXUKXC7IY@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Beniamino,

Am Dienstag, 6. Mai 2014, 19:10:10 schrieb Beniamino Galvani:
> Add new vendor prefixes for:
> 
>     * Mundo Reader S.L., a company that produces tablets and e-readers
>     * Radxa, manufacturer of ARM boards
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>

Just FYI, I've sent both patches off, as part of my dt changes pull request on 
monday.


Heiko

> ---
> 
> v2:
>  - use mundoreader prefix instead of bq as suggested by Heiko Stuebner
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> b/Documentation/devicetree/bindings/vendor-prefixes.txt index
> abc3080..53bd92f 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -79,6 +79,7 @@ microchip	Microchip Technology Inc.
>  mosaixtech	Mosaix Technologies, Inc.
>  moxa	Moxa
>  mpl	MPL AG
> +mundoreader	Mundo Reader S.L.
>  mxicy	Macronix International Co., Ltd.
>  national	National Semiconductor
>  neonode		Neonode Inc.
> @@ -98,6 +99,7 @@ powervr	PowerVR (deprecated, use img)
>  qca	Qualcomm Atheros, Inc.
>  qcom	Qualcomm Technologies, Inc
>  qnap	QNAP Systems, Inc.
> +radxa	Radxa
>  raidsonic	RaidSonic Technology GmbH
>  ralink	Mediatek/Ralink Technology Corp.
>  ramtron	Ramtron International
