From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 31 Oct 2013 09:16:03 -0700
Subject: [PATCH 3/4] mfd: sec-core: Add cells for S5M8767-clocks
In-Reply-To: <1383202124-1775-4-git-send-email-tushar.behera@linaro.org>
References: <1383202124-1775-1-git-send-email-tushar.behera@linaro.org>
 <1383202124-1775-4-git-send-email-tushar.behera@linaro.org>
Message-ID: <20131031161603.GB9587@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 31 Oct 2013, Tushar Behera wrote:

> S5M8767 chip has 3 crystal oscillators running at 32KHz. These are
> supported by s2mps11-clk driver.
> 
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> CC: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/sec-core.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
> index 34c18fb..020b86b 100644
> --- a/drivers/mfd/sec-core.c
> +++ b/drivers/mfd/sec-core.c
> @@ -56,7 +56,9 @@ static struct mfd_cell s5m8767_devs[] = {
>  		.name = "s5m8767-pmic",
>  	}, {
>  		.name = "s5m-rtc",
> -	},
> +	}, {
> +		.name = "s5m8767-clk",
> +	}
>  };
>  
>  static struct mfd_cell s2mps11_devs[] = {

Acked-by: Lee Jones <lee.jones@linaro.org>

I'd prefer to take this patch in via the MFD tree once you have
support from the other maintainers for the set.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
