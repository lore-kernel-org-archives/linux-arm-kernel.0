From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 20 Oct 2016 14:01:24 +0200
Subject: [PATCH v2 1/6] ARM: at91: Documentation: add samx7 families
In-Reply-To: <20161020094135.18221-2-alexandre.belloni@free-electrons.com>
References: <20161020094135.18221-1-alexandre.belloni@free-electrons.com>
 <20161020094135.18221-2-alexandre.belloni@free-electrons.com>
Message-ID: <ae042bfa-4e92-a3ac-386a-31aeb8798776@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 20/10/2016 ? 11:41, Alexandre Belloni a ?crit :
> The Atmel sams70, samv70 and samv71 are Cortex-M7 based MCUs that can run
> Linux (without MMU).
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  Documentation/arm/Atmel/README | 44 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/arm/Atmel/README b/Documentation/arm/Atmel/README
> index 6ca78f818dbf..e403697ee9fc 100644
> --- a/Documentation/arm/Atmel/README
> +++ b/Documentation/arm/Atmel/README
> @@ -14,9 +14,9 @@ official Atmel product name. Anyway, files, directories, git trees,
>  git branches/tags and email subject always contain this "at91" sub-string.
>  
>  
> -AT91 SoCs

Nope: AT91 is our historical name within the Linux community, we will
keep it.

> ----------
> -Documentation and detailled datasheet for each product are available on
> +SMART SoCs

And I'm not sure about the naming of the product line nowadays:
Atmel | SMART MPUs?
Microchip / Atmel | SMART MPUs?
Microchip MPUs?

But SoC is definitively too generic and "SMART" not needed here: let's
keep the MPUs/MCUs only difference for this document.

> +----------
> +Documentation and detailed datasheet for each product are available on
>  the Atmel website: http://www.atmel.com.
>  
>    Flavors:
> @@ -101,6 +101,44 @@ the Atmel website: http://www.atmel.com.
>          + Datasheet
>            http://www.atmel.com/Images/Atmel-11267-32-bit-Cortex-A5-Microcontroller-SAMA5D2_Datasheet.pdf
>  
> +SMART MCUs
> +----------
> +    * ARM Cortex-M7 MCUs
> +      - sams70 family
> +        - sams70j19
> +        - sams70j20
> +        - sams70j21
> +        - sams70n19
> +        - sams70n20
> +        - sams70n21
> +        - sams70q19
> +        - sams70q20
> +        - sams70q21
> +        + Datasheet
> +          http://www.atmel.com/Images/Atmel-11242-32-bit-Cortex-M7-Microcontroller-SAM-S70Q-SAM-S70N-SAM-S70J_Datasheet.pdf
> +
> +      - samv70 family
> +        - samv70j19
> +        - samv70j20
> +        - samv70n19
> +        - samv70n20
> +        - samv70q19
> +        - samv70q20
> +        + Datasheet
> +          http://www.atmel.com/Images/Atmel-11297-32-bit-Cortex-M7-Microcontroller-SAM-V70Q-SAM-V70N-SAM-V70J_Datasheet.pdf
> +
> +      - samv71 family
> +        - samv71j19
> +        - samv71j20
> +        - samv71j21
> +        - samv71n19
> +        - samv71n20
> +        - samv71n21
> +        - samv71q19
> +        - samv71q20
> +        - samv71q21
> +        + Datasheet
> +          http://www.atmel.com/Images/Atmel-44003-32-bit-Cortex-M7-Microcontroller-SAM-V71Q-SAM-V71N-SAM-V71J_Datasheet.pdf
>  
>  Linux kernel information
>  ------------------------
> 


-- 
Nicolas Ferre
