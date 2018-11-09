From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 9 Nov 2018 19:29:28 +0100
Subject: [PATCH v3 1/3] dt-bindings: Add vendor prefix for Smartlabs LLC
In-Reply-To: <1541706240-30036-2-git-send-email-christianshewitt@gmail.com>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
 <1541706240-30036-1-git-send-email-christianshewitt@gmail.com>
 <1541706240-30036-2-git-send-email-christianshewitt@gmail.com>
Message-ID: <ae4a4f99-eecc-7a71-5007-d171449c8619@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.11.18 um 20:43 schrieb Christian Hewitt:
> Smartlabs LLC are a professional integrator of Interactive TV solutions
> and IPTV/VOD devices (https://www.smartlabs.tv/en/about/).
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 4b1a2a8..c424fe0 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -357,6 +357,7 @@ sirf	SiRF Technology, Inc.
>  sis	Silicon Integrated Systems Corp.
>  sitronix	Sitronix Technology Corporation
>  skyworks	Skyworks Solutions, Inc.
> +smartlabs	Smartlabs LLC

You added the LLC but did not upper-case the L - intentional?

Regards,
Andreas

>  smsc	Standard Microsystems Corporation
>  snps	Synopsys, Inc.
>  socionext	Socionext Inc.
> 


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
