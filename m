From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 10 Aug 2014 13:16:37 -0700
Subject: [PATCH] devicetree: bindings: Document Gateworks vendor prefix
In-Reply-To: <1407658509-1773-1-git-send-email-tharvey@gateworks.com>
References: <1407658509-1773-1-git-send-email-tharvey@gateworks.com>
Message-ID: <53E7D325.4060802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 10/08/2014 01:15, Tim Harvey a ?crit :
> Add Gateworks Corporation to the list of device tree vendor prefixes.
>
> Gateworks designs and manufactures single board computers designed for
> embedded wireless and wired network applications.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>   Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 46a311e..803fa4f 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -54,6 +54,7 @@ globalscale	Globalscale Technologies, Inc.
>   gmt	Global Mixed-mode Technology, Inc.
>   google	Google, Inc.
>   gumstix	Gumstix, Inc.
> +gw	Gateworks Corporation

I would go with "gateworks" here, "gw" is usually a shorter term for 
"gateway", and there is an actual company called "Gateway" also 
manufacturing various types of computers.
-- 
Florian
