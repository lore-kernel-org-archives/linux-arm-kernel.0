From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 17 Apr 2014 17:04:40 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzJdIEFSTTogZHRzOiBpbXgyNy1wZGs6IEFkZCBrZXlw?=
 =?UTF-8?B?YWQgc3VwcG9ydA==?=
In-Reply-To: <1397738561-3335-2-git-send-email-festevam@gmail.com>
References: <1397738561-3335-1-git-send-email-festevam@gmail.com>
 <1397738561-3335-2-git-send-email-festevam@gmail.com>
Message-ID: <1397739880.499030540@f420.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thu, 17 Apr 2014 09:42:41 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx27-pdk.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
> index c629a8c..2b7b24f 100644
> --- a/arch/arm/boot/dts/imx27-pdk.dts
> +++ b/arch/arm/boot/dts/imx27-pdk.dts
> @@ -10,6 +10,7 @@
>   */
>  
>  /dts-v1/;
> +#include <dt-bindings/input/input.h>

I think we can include this into imx27.dtsi, same as other files.

---
