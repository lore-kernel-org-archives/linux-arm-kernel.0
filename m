From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed, 2 Jul 2014 10:10:52 +0200
Subject: [PATCH 01/33] Documentation: dt: document all the atmel pmc
 compatibles
In-Reply-To: <1404223962-30471-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404223962-30471-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1404223962-30471-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140702101052.3c9a452c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  1 Jul 2014 16:12:10 +0200
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> Documentation for atmel-pmc only list one compatible, add the
> remaining compatible strings.
> 
> Signed-off-by: Alexandre Belloni
> <alexandre.belloni@free-electrons.com> ---
>  Documentation/devicetree/bindings/arm/atmel-pmc.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-pmc.txt
> b/Documentation/devicetree/bindings/arm/atmel-pmc.txt index
> 389bed5056e8..4ce09d1acdc9 100644 ---
> a/Documentation/devicetree/bindings/arm/atmel-pmc.txt +++
> b/Documentation/devicetree/bindings/arm/atmel-pmc.txt @@ -1,7 +1,10 @@
>  * Power Management Controller (PMC)
>  
>  Required properties:
> -- compatible: Should be "atmel,at91rm9200-pmc"
> +- compatible: Should be "atmel,<chip>-pmc".
> +	<chip> can be: at91rm9200, at91sam9260, at91sam9g45,
> at91sam9n12,
> +	at91sam9x5
> +

You missed sama5d3.

>  - reg: Should contain PMC registers location and length
>  
>  Examples:



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
