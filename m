From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 9 May 2016 16:24:44 +0100
Subject: [PATCH] mfd: ab8500-debugfs: trivial fix of spelling mistake on
 "between"
In-Reply-To: <1461620545-29731-1-git-send-email-colin.king@canonical.com>
References: <1461620545-29731-1-git-send-email-colin.king@canonical.com>
Message-ID: <20160509152444.GB19473@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Apr 2016, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> fix spelling mistake, beetween -> between
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/mfd/ab8500-debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
> index 69d9fff..0aecd7b 100644
> --- a/drivers/mfd/ab8500-debugfs.c
> +++ b/drivers/mfd/ab8500-debugfs.c
> @@ -2563,7 +2563,7 @@ static ssize_t ab8500_gpadc_trig_timer_write(struct file *file,
>  
>  	if (user_trig_timer & ~0xFF) {
>  		dev_err(dev,
> -			"debugfs error input: should be beetween 0 to 255\n");
> +			"debugfs error input: should be between 0 to 255\n");
>  		return -EINVAL;
>  	}
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
