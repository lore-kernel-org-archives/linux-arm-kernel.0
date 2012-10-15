From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 15 Oct 2012 08:08:54 +0200
Subject: [PATCH 4/5] ARM: AT91: Add AT91RM9200 DT board
In-Reply-To: <1350251199-28065-5-git-send-email-manabian@gmail.com>
References: <1350251199-28065-1-git-send-email-manabian@gmail.com>
 <1350251199-28065-5-git-send-email-manabian@gmail.com>
Message-ID: <20121015060854.GU12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23:46 Sun 14 Oct     , Joachim Eastwood wrote:
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
>  arch/arm/mach-at91/Kconfig           |  8 +++++
>  arch/arm/mach-at91/Makefile          |  1 +
>  arch/arm/mach-at91/board-rm9200-dt.c | 59 ++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-at91/generic.h         |  1 +
>  arch/arm/mach-at91/setup.c           | 14 +++++++++
>  5 files changed, 83 insertions(+)
>  create mode 100644 arch/arm/mach-at91/board-rm9200-dt.c
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index d9b0546..3f45906 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -505,6 +505,14 @@ endif
>  
>  comment "Generic Board Type"
>  
> +config MACH_AT91RM9200_DT
> +	bool "Atmel AT91RM9200 Evaluation Kits with device-tree support"
> +	select SOC_AT91RM9200
depends on
> +	select USE_OF
> +	help
> +	  Select this if you want to experiment device-tree with
> +	  an Atmel RM9200 Evaluation Kit.
> +

Best Regards,
J.
