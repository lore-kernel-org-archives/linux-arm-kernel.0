From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 19 Feb 2014 19:59:33 +0400
Subject: =?UTF-8?B?UmU6IFtQYXRjaCB2MyAyMC8yM10gQVJNOiBjb25maWc6IEFkZCBhIG11bHRp?=
 =?UTF-8?B?X3Y1X2RlZmNvbmZpZw==?=
In-Reply-To: <2242951.MozLvvuPx0@wuerfel>
References: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
 <1392822524.597155607@f84.i.mail.ru> <2242951.MozLvvuPx0@wuerfel>
Message-ID: <1392825573.346096924@f191.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?????, 19 ??????? 2014, 16:54 +01:00 ?? Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 19 February 2014 19:08:44 Alexander Shiyan wrote:
> > ?????, 19 ??????? 2014, 15:54 +01:00 ?? Arnd Bergmann <arnd@arndb.de>:
> > > On Wednesday 19 February 2014 18:19:08 Alexander Shiyan wrote:
> 
> > > > Should we disable lowlevel debug for multi-* config?
> > > 
> > > Yes, definitely.
> > > 
> > > On a related note, I'd like to add a CONFIG_BROKEN_MULTIPLATFORM Kconfig
> > > symbol and make all options depend on that which will result in a kernel
> > >
> > 
> > config DEBUG_LL
> >   depends on! ARCH_MULTIPLATFORM
> > 
> > is not enough for this?
> 
> No, because that means you can no longer enable DEBUG_LL for any
> kernel on MVEBU, IMX or any platform that depends on ARCH_MULTIPLATFORM.

Case when I chose multiplatform but I know exactly what machine/platform I use?
OK. Understood.

---
