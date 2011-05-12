From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 12 May 2011 10:34:40 +0900
Subject: [PATCH] leds: drop leds-h1940 driver
In-Reply-To: <201105061101.34589.anarsoul@gmail.com>
References: <1303912597-32653-1-git-send-email-anarsoul@gmail.com>
	<00f701cc0ba4$3cb4b680$b61e2380$%kim@samsung.com>
	<201105061101.34589.anarsoul@gmail.com>
Message-ID: <03c101cc1044$c53b7350$4fb259f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasily Khoruzhick wrote:
> 
> On Friday 06 May 2011 07:15:27 Kukjin Kim wrote:
> > Hi Vasily,
> 
> Hi
> 
Hi :)

> > Hmm, regarding maintainer who is Richard Purdie(LED) in this case should
be
> > added in Cc. (Cc'ed him)
> 
> Sorry, forgot to add him to CC :(
> 
No problem :)

> > And I think need following with this patch.
> >
> > --- a/arch/arm/configs/s3c2410_defconfig
> > +++ b/arch/arm/configs/s3c2410_defconfig
> > @@ -389,7 +389,6 @@ CONFIG_MMC_SPI=m
> >  CONFIG_MMC_S3C=y
> >  CONFIG_LEDS_CLASS=m
> >  CONFIG_LEDS_S3C24XX=m
> > -CONFIG_LEDS_H1940=m
> >  CONFIG_LEDS_PCA9532=m
> >  CONFIG_LEDS_GPIO=m
> >  CONFIG_LEDS_PCA955X=m
> 
> Sure. Can you commit this change to your tree, or should I resend patch
with
> this change?
> 
Ok, I will do it after merging your patch into Richard's tree.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
