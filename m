From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 10 Dec 2013 06:23:07 +0900
Subject: [PATCH] ARM: s3c24xx: get rid of custom <mach/gpio.h>
In-Reply-To: <CACRpkdZuk3zzhDnj3wJg1cmuqX0Cj-qQ--sBzEEV_XWyeDje3w@mail.gmail.com>
References: <1386322280-23756-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZuk3zzhDnj3wJg1cmuqX0Cj-qQ--sBzEEV_XWyeDje3w@mail.gmail.com>
Message-ID: <52A634BB.8020909@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/13 20:58, Linus Walleij wrote:
> On Fri, Dec 6, 2013 at 10:31 AM, Linus Walleij<linus.walleij@linaro.org>  wrote:
>
Hi Linus,

>> This isolates the custom S3C24xx GPIO definition table to
>> <linux/platform_data/gpio-samsung-s3x24xx.h>
>
> Maybe I'm too trigger happy. I'll send a combined series with
> S3C24xx, S3C64xx and maybe also S5P variants all fixed
> so you can see the overall idea here. Hold on.
>
Basically, looks good to me and let me hold on look at this patch? as 
you requested ;-)

Anyway, thanks for your care of samsung gpio stuff.

- Kukjin
