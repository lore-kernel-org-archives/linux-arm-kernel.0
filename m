From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 27 May 2015 11:32:10 +0100
Subject: [PATCH] mfd: mediatek: Add GPIO sub module support into mfd.
In-Reply-To: <1432717835-16398-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1432717835-16398-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <20150527103210.GI11677@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 May 2015, Hongzhou Yang wrote:

> Base on Lee Jones' comment, change pinctrl subnode name.
> 
> ---
> Register pinctrl subnode into 6397 mfd cell.

Sascha already mentioned what's wrong here, so I'll not labour the
point.

I'm feeling generous, I'll apply this and make the necessary changes
myself.  Please bear the points in mind for next time however.

Applied, thanks.

> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/mt6397-core.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 09bc780..e50a9bc 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -34,6 +34,9 @@ static const struct mfd_cell mt6397_devs[] = {
>  	}, {
>  		.name = "mt6397-clk",
>  		.of_compatible = "mediatek,mt6397-clk",
> +	}, {
> +		.name = "mt6397-pinctrl",
> +		.of_compatible = "mediatek,mt6397-pinctrl",
>  	},
>  };
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
