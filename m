From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 14 Jun 2011 14:51:12 +0400
Subject: [PATCH] arm mach-s3c2440 mach-mini2440: New LCD-W35i support
In-Reply-To: <BANLkTikfLQH=_tSMkFGB7Jx_4vUKPmn-3w@mail.gmail.com>
References: <BANLkTikfLQH=_tSMkFGB7Jx_4vUKPmn-3w@mail.gmail.com>
Message-ID: <4DF73D20.20700@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 14-06-2011 1:21, ????? ????????? wrote:

> From: Denis Kuzmenko <dart@solonet.org.ua>

    Need an empty line here...

> LCD-W35i support for Mini2440 development board

> --- linux-2.6.39.1/arch/arm/mach-s3c2440/mach-mini2440.c
> 2011-06-03 03:34:20.000000000 +0300
> +++ linux-2.6.39.1-dart/arch/arm/mach-s3c2440/mach-mini2440.c
> 2011-06-13 23:37:38.785984118 +0300
> @@ -167,6 +167,20 @@ static struct s3c2410fb_display mini2440
>                  .lcdcon5        = (S3C2410_LCDCON5_FRM565 |
>                                     S3C2410_LCDCON5_HWSWP),
>          },
> +       /* LCD-W35i 3.5" display (LQ035Q1DG06)*/
> +       [3] = {
> +               _LCD_DECLARE(
> +                       7,              /* clock */
> +                       320, 68, 66, 4, /* xres, margin_right,
> margin_left, hsync */
> +                       240, 4, 4, 9,   /* yres, margin_top,
> margin_bottom, vsync */

    Your patch is line wrapped. Seems easy to fix though...

WBR, Sergei
