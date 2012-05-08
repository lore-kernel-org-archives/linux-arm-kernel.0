From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 08 May 2012 14:38:37 +0900
Subject: [PATCH 2/5] ARM: S3C24XX: move plat-s3c24xx/irq.c into common.c
In-Reply-To: <201205072230.00758.heiko@sntech.de>
References: <201205071939.37433.heiko@sntech.de>
 <201205071941.33343.heiko@sntech.de> <201205071959.22122.arnd@arndb.de>
 <201205072230.00758.heiko@sntech.de>
Message-ID: <017901cd2cdc$d1214c20$7363e460$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Hi Arnd,
> 
> Am Montag 07 Mai 2012, 21:59:21 schrieb Arnd Bergmann:
> > On Monday 07 May 2012, Heiko St?bner wrote:
> > > Again following the model set out by s3c64xx.
> > >
> > > As checkpatch showed a lot of style errors and warning, these got
> fixed
> > > too.
> > >
> > > Signed-off-by: Heiko Stueber <heiko@sntech.de>
> >
> > I object on two grounds:
> >
> > 1. there are plans to move irq chip drivers to drivers/irqchip
> eventually,
> > so I think it makes little sense to merge the current implementation
> into
> > another file. That just makes it harder to split it out again. Better
> leave
> > the file named irq.c and just move it to the mach-s3c24xx for now.
> >
> > 2. You should *never* move code around and change it at the same time
> > if you have a choice. Instead if you discover coding style issues with
> > code you want to move, fix those first and then do a second patch to
> > move it without further changes. Otherwise it becomes very hard to
> > check that the coding style changes are actually correct.
> 
> thanks for the two pointers, you are of course right with them.
> I will do another round of the patches.
> 
Yes, agree.

I will apply Heiko's this series except 2nd patch.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
