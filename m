From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 Sep 2015 13:44:49 +0200
Subject: [PATCH v3 01/26] ARM: pxa: magician: Fix indentation in machine
 files
In-Reply-To: <55FA4781.30103@tul.cz> (Petr Cvek's message of "Thu, 17 Sep 2015
 06:54:25 +0200")
References: <cover.1442462898.git.petr.cvek@tul.cz> <55FA4781.30103@tul.cz>
Message-ID: <87zj09mmku.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> This patch fixes the indentation for the HTC Magician machine definition.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
>  arch/arm/mach-pxa/include/mach/magician.h |  62 ++---
>  arch/arm/mach-pxa/magician.c              | 368 +++++++++++++++---------------
>  2 files changed, 215 insertions(+), 215 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/include/mach/magician.h b/arch/arm/mach-pxa/include/mach/magician.h
> index ba6a6e1..a88f551 100644
> --- a/arch/arm/mach-pxa/include/mach/magician.h
> +++ b/arch/arm/mach-pxa/include/mach/magician.h
> @@ -21,10 +21,10 @@
>  
>  #define GPIO0_MAGICIAN_KEY_POWER		0
>  #define GPIO9_MAGICIAN_UNKNOWN			9
> -#define GPIO10_MAGICIAN_GSM_IRQ			10
> +#define GPIO10_MAGICIAN_GSM_IRQ		10
I think your editor deserves a bit of configuration. Have a look at this file
with "less .../magician.h". Give that the tab after the ".._IRQ" begins at
column 31 (column 0 being the first), the first tab goes to column 32, the
second to 40. All other numbers are at column 48.

Ditto for the next lines.
>  
> -#define EGPIO_MAGICIAN_TOPPOLY_POWER		MAGICIAN_EGPIO(0, 2)
> -#define EGPIO_MAGICIAN_LED_POWER		MAGICIAN_EGPIO(0, 5)
> -#define EGPIO_MAGICIAN_GSM_RESET		MAGICIAN_EGPIO(0, 6)
> -#define EGPIO_MAGICIAN_LCD_POWER		MAGICIAN_EGPIO(0, 7)
> -#define EGPIO_MAGICIAN_SPK_POWER		MAGICIAN_EGPIO(1, 0)
> -#define EGPIO_MAGICIAN_EP_POWER			MAGICIAN_EGPIO(1, 1)
> -#define EGPIO_MAGICIAN_IN_SEL0			MAGICIAN_EGPIO(1, 2)
> -#define EGPIO_MAGICIAN_IN_SEL1			MAGICIAN_EGPIO(1, 3)
> -#define EGPIO_MAGICIAN_MIC_POWER		MAGICIAN_EGPIO(1, 4)
> -#define EGPIO_MAGICIAN_CODEC_RESET		MAGICIAN_EGPIO(1, 5)
> -#define EGPIO_MAGICIAN_CODEC_POWER		MAGICIAN_EGPIO(1, 6)
> -#define EGPIO_MAGICIAN_BL_POWER			MAGICIAN_EGPIO(1, 7)
> -#define EGPIO_MAGICIAN_SD_POWER			MAGICIAN_EGPIO(2, 0)
> -#define EGPIO_MAGICIAN_CARKIT_MIC		MAGICIAN_EGPIO(2, 1)
> +#define EGPIO_MAGICIAN_TOPPOLY_POWER	MAGICIAN_EGPIO(0, 2)
> +#define EGPIO_MAGICIAN_LED_POWER	MAGICIAN_EGPIO(0, 5)
> +#define EGPIO_MAGICIAN_GSM_RESET	MAGICIAN_EGPIO(0, 6)
> +#define EGPIO_MAGICIAN_LCD_POWER	MAGICIAN_EGPIO(0, 7)
> +#define EGPIO_MAGICIAN_SPK_POWER	MAGICIAN_EGPIO(1, 0)
> +#define EGPIO_MAGICIAN_EP_POWER	MAGICIAN_EGPIO(1, 1)
Here same problem for xxx_EP_POWER.

> +#define EGPIO_MAGICIAN_IN_SEL0		MAGICIAN_EGPIO(1, 2)
> +#define EGPIO_MAGICIAN_IN_SEL1		MAGICIAN_EGPIO(1, 3)
> +#define EGPIO_MAGICIAN_MIC_POWER	MAGICIAN_EGPIO(1, 4)
> +#define EGPIO_MAGICIAN_CODEC_RESET	MAGICIAN_EGPIO(1, 5)
> +#define EGPIO_MAGICIAN_CODEC_POWER	MAGICIAN_EGPIO(1, 6)
> +#define EGPIO_MAGICIAN_BL_POWER	MAGICIAN_EGPIO(1, 7)
Ditto.

> +#define EGPIO_MAGICIAN_SD_POWER	MAGICIAN_EGPIO(2, 0)
Ditto.

> diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c

> index a9761c2..c10f932 100644
> --- a/arch/arm/mach-pxa/magician.c
> +++ b/arch/arm/mach-pxa/magician.c
Same remark, check your favorite editor first please.

Cheers.

--
Robert
