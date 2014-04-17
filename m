From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 17 Apr 2014 17:01:32 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIEFSTTogZHRzOiBpbXgyNy1wZGs6IEFkZCBOQU5E?=
 =?UTF-8?B?IHN1cHBvcnQ=?=
In-Reply-To: <1397738561-3335-1-git-send-email-festevam@gmail.com>
References: <1397738561-3335-1-git-send-email-festevam@gmail.com>
Message-ID: <1397739692.667087851@f420.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thu, 17 Apr 2014 09:42:40 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx27-pdk.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
> index 971961f..c629a8c 100644
> --- a/arch/arm/boot/dts/imx27-pdk.dts
> +++ b/arch/arm/boot/dts/imx27-pdk.dts
> @@ -84,6 +84,12 @@
>  	status = "okay";
>  };
>  
> +&nfc {
> +	status = "okay";
> +	nand-ecc-mode = "hw";
> +	nand-on-flash-bbt;
> +};

You also should add pin definitions.

---
