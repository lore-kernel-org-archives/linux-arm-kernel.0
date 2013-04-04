From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 04 Apr 2013 10:02:00 +0900
Subject: [PATCH 1/4] ARM: s3c24xx: Removed unneeded dependency on
 ARCH_S3C24XX for boards
In-Reply-To: <1362225644.599345374@f82.mail.ru>
References: <1362216174-10478-1-git-send-email-shc_work@mail.ru>
 <201303021143.38390.arnd@arndb.de> <1362225644.599345374@f82.mail.ru>
Message-ID: <26f101ce30d0$0374a530$0a5def90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Shiyan wrote:
> 
> > On Saturday 02 March 2013, Alexander Shiyan wrote:
> > > Board options are already under "if ARCH_S3C24XX" condition, so
> > > additional dependencies on this symbol can be removed.
> > >
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> >
> > Hi Alexander,
> >
> > Is this just a cosmetic change that has no other consequences, or do you
> > have other follow-up patches that depend on patches 1-3?
> 
> Hello Arnd.
> Nothing more yet. Perhaps I'll do a merging some parts of the code for
> different versions of the CPU into one unit and some future changes
> may remove some Kconfig symbols, so it is only initial Kconfig cleaning.
> Thanks.
> 
Looks good to me on patches 1-3 but for 4th patch, see my comments on that.

Applied 1-3 patches, thanks.

- Kukjin
