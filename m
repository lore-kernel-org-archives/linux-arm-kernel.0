From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 Jun 2014 14:30:30 +0100
Subject: [PATCH 1/4] devicetree: bindings: Document murata vendor prefix
In-Reply-To: <1403612356-23685-2-git-send-email-ch.naveen@samsung.com>
References: <1403612356-23685-1-git-send-email-ch.naveen@samsung.com>
 <1403612356-23685-2-git-send-email-ch.naveen@samsung.com>
Message-ID: <20140624133030.GH5856@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 01:19:13PM +0100, Naveen Krishna Chatradhi wrote:
> Add Murata Manufacturing Co., Ltd. to the list of device tree
> vendor prefixes.
> 
> Murata manufactures NTC (Negative Temperature Coefficient) based
> Thermistors for small scale applications like Mobiles and PDAs.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> ---
> This changes is needed for the following reasons
> 
> 1. The vendor prefix "ntc" is not defined in vendor-prefixes.txt
>    Thus, giving an error when checked with scripts/checkpatch.pl
> 2. Murata Manufacturing Co., Ltd. Is the vendor for the
>    NTC (Negative Temperature Coefficient) based thermistors.
>    Hence, "murata" is the right vendor-prefix, Not "ntc".
> 3. NTC is a technology used, But the prefix "ntc" is wrongly
>    and heavily used in the driver and the documentation.
> 
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 4d7f375..a39b7d7 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -84,6 +84,7 @@ moxa	Moxa
>  mpl	MPL AG
>  mundoreader	Mundo Reader S.L.
>  mxicy	Macronix International Co., Ltd.
> +murata	Murata Manufacturing Co., Ltd.

Nit: please keep this list in alphabetical order.

Otherwise, this looks fine to me. With the order fixed:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  national	National Semiconductor
>  neonode		Neonode Inc.
>  netgear	NETGEAR
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
