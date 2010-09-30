From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 30 Sep 2010 20:45:36 +0900
Subject: [PATCH] ARM: Samsung S5P: Unify defines for both gpio interrupt
	types
In-Reply-To: <00e101cb6093$34f4d270$9ede7750$%szyprowski@samsung.com>
References: <1285841906-21194-1-git-send-email-m.szyprowski@samsung.com>
	<00a501cb6091$e25692c0$a703b840$%kim@samsung.com>
	<00e101cb6093$34f4d270$9ede7750$%szyprowski@samsung.com>
Message-ID: <00a801cb6095$0212ef20$0638cd60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Hello,
> 
Hi,

(snip)

> >
> > Ok..firstly looks ok to me now.
> > But I don't know...in the future may have to revert back due to S5P64XX.
> 
> Well, these defines are used only by plat-s5p/irq-{eint,gpioint}.c. These
generic
> functions cannot be used for S5P64XX anyway, because it has S3C64XX style
of
> gpio
> registers afair. IMHO this shouldn't be a problem. Just S5P64XX would need
to
> provide it's own code for gpio/ext interrupts (or share the code with
s3c64xx
> somehow).
> 
Yes, you're right. It seems to have been useless worry.
However, it is likely to think of once again later.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
