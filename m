From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 3 Oct 2018 18:42:55 +0100
Subject: [PATCH v2] nvmem: lpc18xx_eeprom: remove unused variable
In-Reply-To: <20181003072430.20966-1-brgl@bgdev.pl>
References: <20181003072430.20966-1-brgl@bgdev.pl>
Message-ID: <e51fd8aa-50bc-569b-4523-fc34ab0f5355@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/10/18 08:24, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Remove a variable that's no longer used from lpc18xx_eeprom_remove().
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
> v1 -> v2:
> - added the Reported-by tag
> 
>   drivers/nvmem/lpc18xx_eeprom.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
> index b42dbaddb419..66cff1e2147a 100644
> --- a/drivers/nvmem/lpc18xx_eeprom.c
> +++ b/drivers/nvmem/lpc18xx_eeprom.c
> @@ -255,7 +255,6 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
>   static int lpc18xx_eeprom_remove(struct platform_device *pdev)
>   {
>   	struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
> -	int ret;
>   
>   	clk_disable_unprepare(eeprom->clk);
>   
> 
