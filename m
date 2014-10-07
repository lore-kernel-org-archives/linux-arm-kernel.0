From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 7 Oct 2014 13:03:22 +0100
Subject: [PATCH v3 2/4] Documentation: devicetree: bindings: Document
 deprecated device vendor name to fix related warning
In-Reply-To: <1412682308-8784-3-git-send-email-darshanapadmadas@gmail.com>
References: <1412682308-8784-1-git-send-email-darshanapadmadas@gmail.com>
 <1412682308-8784-3-git-send-email-darshanapadmadas@gmail.com>
Message-ID: <20141007120322.GI24725@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 12:45:06PM +0100, Darshana Padmadas wrote:
> This patch documents deprecated vendor name of device isl29028 for compatibility with older kernels.
> 
> Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>

Acked-by: Mark Rutland Mark.rutland at arm.com>

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index ac7269f..e2503b8 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -68,6 +68,7 @@ img	Imagination Technologies Ltd.
>  intel	Intel Corporation
>  intercontrol	Inter Control Group
>  isee	ISEE 2007 S.L.
> +isil 	Intersil (deprecated, use isl)
>  isl	Intersil
>  karo	Ka-Ro electronics GmbH
>  keymile	Keymile GmbH
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
