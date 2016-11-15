From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 15 Nov 2016 14:48:45 +0100
Subject: [PATCH] ASoC: mioa701_wm9713: add missing white space in
 dev_err message
In-Reply-To: <20161112163025.4801-1-colin.king@canonical.com>
References: <20161112163025.4801-1-colin.king@canonical.com>
Message-ID: <20161115144845.0aafbcc9@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, 12 Nov 2016 16:30:25 +0000 Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a missing whitespace in the dev_err message between
> "will" and "lead".  Add the whitespace.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/soc/pxa/mioa701_wm9713.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
> index d1661fa..0fe0abe 100644
> --- a/sound/soc/pxa/mioa701_wm9713.c
> +++ b/sound/soc/pxa/mioa701_wm9713.c
> @@ -187,7 +187,7 @@ static int mioa701_wm9713_probe(struct platform_device *pdev)
>  	mioa701.dev = &pdev->dev;
>  	rc = devm_snd_soc_register_card(&pdev->dev, &mioa701);
>  	if (!rc)
> -		dev_warn(&pdev->dev, "Be warned that incorrect mixers/muxes setup will"
> +		dev_warn(&pdev->dev, "Be warned that incorrect mixers/muxes setup will "
>  			 "lead to overheating and possible destruction of your device."
>  			 " Do not use without a good knowledge of mio's board design!\n");
>
There is already a continuation line that has a whitespace in front. It
would be nice to be consistent and also add the missing whitespace in
front of the succeeding line...


Lothar Wa?mann
