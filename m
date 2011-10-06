From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 5 Oct 2011 20:37:03 -0700
Subject: [PATCH 07/16] input: ambakmi: Enable module alias autogeneration
	for AMBA drivers
In-Reply-To: <1317830707-17517-8-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
	<1317830707-17517-8-git-send-email-dave.martin@linaro.org>
Message-ID: <20111006033702.GB20217@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 05, 2011 at 05:04:58PM +0100, Dave Martin wrote:
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Dmitry Torokhov <dtor@mail.ru>

> ---
>  drivers/input/serio/ambakmi.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
> index 12abc50..8407d5b 100644
> --- a/drivers/input/serio/ambakmi.c
> +++ b/drivers/input/serio/ambakmi.c
> @@ -195,6 +195,8 @@ static struct amba_id amba_kmi_idtable[] = {
>  	{ 0, 0 }
>  };
>  
> +MODULE_DEVICE_TABLE(amba, amba_kmi_idtable);
> +
>  static struct amba_driver ambakmi_driver = {
>  	.drv		= {
>  		.name	= "kmi-pl050",
> -- 
> 1.7.4.1
> 

-- 
Dmitry
