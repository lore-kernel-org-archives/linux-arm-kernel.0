From: Wenyou.Yang@Microchip.com (Yang, Wenyou)
Date: Tue, 26 Dec 2017 09:39:42 +0800
Subject: [PATCH -next] media: atmel-isc: Make local symbol
 fmt_configs_list static
In-Reply-To: <1513994224-86350-1-git-send-email-weiyongjun1@huawei.com>
References: <1513994224-86350-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <fa1db8ce-c93a-cb0c-a5e0-a8886879090e@Microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/12/23 9:57, Wei Yongjun wrote:
> Fixes the following sparse warning:
>
> drivers/media/platform/atmel/atmel-isc.c:338:19: warning:
>   symbol 'fmt_configs_list' was not declared. Should it be static?
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
Acked-by: Wenyou Yang <wenyou.yang@microchip.com>

>   drivers/media/platform/atmel/atmel-isc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/atmel/atmel-isc.c b/drivers/media/platform/atmel/atmel-isc.c
> index 0c26356..2dd72fc 100644
> --- a/drivers/media/platform/atmel/atmel-isc.c
> +++ b/drivers/media/platform/atmel/atmel-isc.c
> @@ -335,7 +335,7 @@ struct isc_device {
>   	},
>   };
>   
> -struct fmt_config fmt_configs_list[] = {
> +static struct fmt_config fmt_configs_list[] = {
>   	{
>   		.fourcc		= V4L2_PIX_FMT_SBGGR8,
>   		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
>
