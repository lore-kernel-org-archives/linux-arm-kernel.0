From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Nov 2015 17:44:26 -0600
Subject: [PATCH] dt-bindings: ARM: add arm,cortex-a72 compatible string
In-Reply-To: <1448364711-31275-1-git-send-email-yamada.masahiro@socionext.com>
References: <1448364711-31275-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20151125234426.GA16040@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 08:31:51PM +0900, Masahiro Yamada wrote:
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied, thanks.

Rob

> ---
> 
>  Documentation/devicetree/bindings/arm/cpus.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 3a07a87..58e240d 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -157,6 +157,7 @@ nodes to be present and contain the properties described below.
>  			    "arm,cortex-a17"
>  			    "arm,cortex-a53"
>  			    "arm,cortex-a57"
> +			    "arm,cortex-a72"
>  			    "arm,cortex-m0"
>  			    "arm,cortex-m0+"
>  			    "arm,cortex-m1"
> -- 
> 1.9.1
> 
