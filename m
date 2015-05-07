From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 7 May 2015 07:58:03 +0100
Subject: [PATCH 1/1] mfd: max77686: Remove unused struct
 max77686_opmode_data
In-Reply-To: <1430932036-23971-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1430932036-23971-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20150507065803.GA3400@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 06 May 2015, Javier Martinez Canillas wrote:

> The defined struct max77686_opmode_data isn't used neither by
> the max77686 mfd driver nor the drivers for its sub-devices.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  include/linux/mfd/max77686.h | 5 -----
>  1 file changed, 5 deletions(-)

Applied, thanks.

> diff --git a/include/linux/mfd/max77686.h b/include/linux/mfd/max77686.h
> index bb995ab9a575..d4b72d519115 100644
> --- a/include/linux/mfd/max77686.h
> +++ b/include/linux/mfd/max77686.h
> @@ -125,9 +125,4 @@ enum max77686_opmode {
>  	MAX77686_OPMODE_STANDBY,
>  };
>  
> -struct max77686_opmode_data {
> -	int id;
> -	int mode;
> -};
> -
>  #endif /* __LINUX_MFD_MAX77686_H */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
