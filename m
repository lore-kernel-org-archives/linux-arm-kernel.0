From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 20 Oct 2016 16:09:33 +0100
Subject: [PATCH v14 2/9] clocksource/drivers/arm_arch_timer: Add a new
 enum for spi type
In-Reply-To: <1475086637-1914-3-git-send-email-fu.wei@linaro.org>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-3-git-send-email-fu.wei@linaro.org>
Message-ID: <20161020150933.GK10234@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2016 at 02:17:10AM +0800, fu.wei at linaro.org wrote:
> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
> index 6f06481..16dcd10 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -45,6 +45,12 @@ enum ppi_nr {
>  	MAX_TIMER_PPI
>  };
>  
> +enum spi_nr {
> +	PHYS_SPI,
> +	VIRT_SPI,
> +	MAX_TIMER_SPI
> +};

Please rename this to arch_timer_spi_nr (as with patch 1 for
s/ppi_nr/arch_timer_ppi_nr/). With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
