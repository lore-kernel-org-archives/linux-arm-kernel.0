From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 12 Jul 2016 11:06:13 -0400
Subject: [PATCH] media: s5p-mfc remove void function return statement
In-Reply-To: <1468283383-3142-1-git-send-email-shuahkh@osg.samsung.com>
References: <1468283383-3142-1-git-send-email-shuahkh@osg.samsung.com>
Message-ID: <901879fc-4964-fcc8-7ba9-f6f41e78bb72@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shuah

On 07/11/2016 08:29 PM, Shuah Khan wrote:
> Remove void function return statement
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  drivers/media/platform/s5p-mfc/s5p_mfc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> index c96421f..b6fde20 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> @@ -495,7 +495,6 @@ static void s5p_mfc_handle_error(struct s5p_mfc_dev *dev,
>  	s5p_mfc_hw_call(dev->mfc_ops, clear_int_flags, dev);
>  	s5p_mfc_clock_off();
>  	wake_up_dev(dev, reason, err);
> -	return;
>  }
>  
>  /* Header parsing interrupt handling */
> 

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
