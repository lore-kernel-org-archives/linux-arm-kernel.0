From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 21 Apr 2012 15:30:24 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCAwMi8xN10gQVJNIGNscHM3MTF4OiBBZGRlZCBDaXJy?=
 =?UTF-8?B?dXMgTG9naWMgRVA3MzEyIENQVSB2YXJpYW50?=
In-Reply-To: <201204211121.49610.arnd@arndb.de>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
 <1334999490-27177-3-git-send-email-shc_work@mail.ru>
 <201204211121.49610.arnd@arndb.de>
Message-ID: <E1SLYWG-0001EX-Qj.shc_work-mail-ru@f78.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sat, 21 Apr 2012 11:21:49 +0000 ?? Arnd Bergmann <arnd@arndb.de>:
> On Saturday 21 April 2012, Alexander Shiyan wrote:
> > 
> > Added register definitions specific to EP7312 and the necessary
> > configuration options.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  arch/arm/include/asm/hardware/ep7312.h         |  106 ++++++++++++++++++++++++
> >  arch/arm/mach-clps711x/Kconfig                 |    9 ++-
> >  arch/arm/mach-clps711x/include/mach/hardware.h |    4 +
> >  drivers/net/irda/Kconfig                       |    3 +-
> >  4 files changed, 119 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/arm/include/asm/hardware/ep7312.h
> 
> I'm missing some historical background here. Why are these files in asm/hardware
> rather than in mach/? Should we move them to the platform directory?

I just placed this header into current place for this cpu.
Of course it can be moved (with others) into platform directory.
I can do other patch for this operation later. For this patch I think it is not important.
