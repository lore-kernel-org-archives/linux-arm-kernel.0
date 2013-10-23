From: robherring2@gmail.com (Rob Herring)
Date: Wed, 23 Oct 2013 17:54:15 -0500
Subject: [PATCHv5][ 1/9] of: add vendor prefix for Eukrea Electromatique.
In-Reply-To: <1382516974-13371-1-git-send-email-denis@eukrea.com>
References: <1382516974-13371-1-git-send-email-denis@eukrea.com>
Message-ID: <52685397.90106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2013 03:29 AM, Denis Carikli wrote:
> Trivial patch to add Eukr?a Electromatique to the list
> of devicetree vendor prefixes.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 2956800..a0329cf 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -25,6 +25,7 @@ denx	Denx Software Engineering
>  emmicro	EM Microelectronic
>  epson	Seiko Epson Corp.
>  est	ESTeem Wireless Modems
> +eukrea  Eukr?a Electromatique
>  fsl	Freescale Semiconductor
>  GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
>  gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
> 
