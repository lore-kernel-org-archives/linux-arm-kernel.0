From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 10 May 2016 10:24:28 +0900
Subject: [PATCH v6 7/9] extcon: max8997: Fix inconsistent indenting
In-Reply-To: <1462519636-3250-6-git-send-email-k.kozlowski@samsung.com>
References: <1462519289-2356-2-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-6-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5731384C.6000209@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2016? 05? 06? 16:27, Krzysztof Kozlowski wrote:
> Fix smatch warning:
> 	max8997_muic_probe() warn: inconsistent indenting
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/extcon/extcon-max8997.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
> index 0afa3e8b5dc3..cf8de5be2405 100644
> --- a/drivers/extcon/extcon-max8997.c
> +++ b/drivers/extcon/extcon-max8997.c
> @@ -737,7 +737,7 @@ static int max8997_muic_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Set initial path for UART */
> -	 max8997_muic_set_path(info, info->path_uart, true);
> +	max8997_muic_set_path(info, info->path_uart, true);
>  
>  	/* Set ADC debounce time */
>  	max8997_muic_set_debounce_time(info, ADC_DEBOUNCE_TIME_25MS);
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
