From: jekhor@gmail.com (Yauhen Kharuzhy)
Date: Mon, 29 Nov 2010 13:25:26 +0200
Subject: [PATCH 05/10] ARM S3C2443: Select properly ARM core type
In-Reply-To: <001001cb8fb5$c8058a90$58109fb0$%kim@samsung.com>
References: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
	<1290969027-10178-5-git-send-email-jekhor@gmail.com>
	<001001cb8fb5$c8058a90$58109fb0$%kim@samsung.com>
Message-ID: <20101129112526.GC7033@jeknote.loshitsa1.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 08:08:38PM +0900, Kukjin Kim wrote:
> Yauhen Kharuzhy wrote:
> > 
> > From: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> > 
> Your e-mail changed?
No, above is my e-mail at my primary job. I use it for patches which were made for my employer.

> > Select ARM920T core when compiling kernel for s3c2443.
> > 
> > Signed-off-by: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> > ---
> >  arch/arm/mach-s3c2443/Kconfig |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-s3c2443/Kconfig b/arch/arm/mach-s3c2443/Kconfig
> > index 0b7f0d6..8814031 100644
> > --- a/arch/arm/mach-s3c2443/Kconfig
> > +++ b/arch/arm/mach-s3c2443/Kconfig
> > @@ -5,6 +5,7 @@
> >  config CPU_S3C2443
> >  	bool
> >  	depends on ARCH_S3C2410
> > +	select CPU_ARM920T
> >  	select S3C2443_DMA if S3C2410_DMA
> >  	select CPU_LLSERIAL_S3C2440
> >  	select SAMSUNG_CLKSRC
> > --
> 
> This is ok to me.
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 

-- 
Yauhen Kharuzhy		jekhor _at_ gmail.com
			JID: jek at jabber.ru

A: No
Q: Should I quote below my post?
