From: jonghwa3.lee@samsung.com (jonghwa3.lee at samsung.com)
Date: Thu, 19 Dec 2013 18:48:54 +0900
Subject: [PATCH Resend 7/7] clk: max77686: Remove redundant break
In-Reply-To: <1387443241-5694-7-git-send-email-sachin.kamat@linaro.org>
References: <1387443241-5694-1-git-send-email-sachin.kamat@linaro.org>
 <1387443241-5694-7-git-send-email-sachin.kamat@linaro.org>
Message-ID: <52B2C106.3070309@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013? 12? 19? 17:54, Sachin Kamat wrote:

> 'break' after 'goto' is redundant. Remove it.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Jonghwa Lee <jonghwa3.lee@samsung.com>
> ---
>  drivers/clk/clk-max77686.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
> index 9f57bc37cd60..b4a1a9719ab0 100644
> --- a/drivers/clk/clk-max77686.c
> +++ b/drivers/clk/clk-max77686.c
> @@ -157,11 +157,9 @@ static int max77686_clk_probe(struct platform_device *pdev)
>  			case MAX77686_CLK_AP:
>  				dev_err(&pdev->dev, "Fail to register CLK_AP\n");
>  				goto err_clk_ap;
> -				break;
>  			case MAX77686_CLK_CP:
>  				dev_err(&pdev->dev, "Fail to register CLK_CP\n");
>  				goto err_clk_cp;
> -				break;
>  			case MAX77686_CLK_PMIC:
>  				dev_err(&pdev->dev, "Fail to register CLK_PMIC\n");
>  				goto err_clk_pmic;


Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>


Thanks,
Jonghwa
