From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 27 Apr 2015 16:06:29 +0300
Subject: [PATCH 10/10] ARM: shmobile: marzen dts: Use generic names for
 device nodes
In-Reply-To: <1430139334-15272-11-git-send-email-geert+renesas@glider.be>
References: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
 <1430139334-15272-11-git-send-email-geert+renesas@glider.be>
Message-ID: <553E3455.9070003@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2015 03:55 PM, Geert Uytterhoeven wrote:

> lan0 -> ethernet

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   arch/arm/boot/dts/r8a7779-marzen.dts | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

> diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
> index 540756cdf3914a2a..20afea6f06ef6735 100644
> --- a/arch/arm/boot/dts/r8a7779-marzen.dts
> +++ b/arch/arm/boot/dts/r8a7779-marzen.dts
[...]
> @@ -176,7 +176,7 @@
>   		};
>   	};
>
> -	lan0_pins: lan0 {
> +	ethernet_pins: ethernet {

    Why change the label?

WBR, Sergei
