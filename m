From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 17 Apr 2016 18:16:51 +0200
Subject: [PATCH 1/2] char: PC rtc: replace blacklist with whitelist
In-Reply-To: <20160410154352.GH5377@piout.net>
References: <1456912137-1578635-1-git-send-email-arnd@arndb.de>
 <CAMuHMdU26GkyUYxs3DJOFRB5LTdYCOaGTMUwFMd9YXYhkS1W3g@mail.gmail.com>
 <20160410154352.GH5377@piout.net>
Message-ID: <11356549.HIf78Z96bJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 10 April 2016 17:43:52 Alexandre Belloni wrote:
> > >  config RTC
> > >         tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"
> > > -       depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV \
> > > -                       && !ARM && !SUPERH && !S390 && !AVR32 && !BLACKFIN && !UML
> > > +       depends on ALPHA || M32R || M68K || MIPS || MN10300 || PPC || X86
> > 
> > ... so please drop it here.
> > 
> 
> Do you plan to resend that one?
> 

Yes, it's in my queue for resending, together with some other RTC patches.

	Arnd
