From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 15:18:18 +0200
Subject: [PATCH 6/7 v6] ARM: l2x0: calculate associativity from ePAPR
 cache props
In-Reply-To: <CACRpkdaTWt=0cbfgrnbah3jHRsvGUnVzsCb1uqFKPUNfvZ+AhA@mail.gmail.com>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
 <65434961.9Ji0STQpff@wuerfel>
 <CACRpkdaTWt=0cbfgrnbah3jHRsvGUnVzsCb1uqFKPUNfvZ+AhA@mail.gmail.com>
Message-ID: <5220736.Vp1uzqqDMY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 September 2014 14:43:55 Linus Walleij wrote:
> 
> >
> > and CACHE_LINE_SIZE seems to be what ePAPR calls cache-block-size, i.e.
> > the fundamental unit of cache management as seen from the CPU, independent
> > of how it is physically organized.
> 
> Yeah. Well, actually that means the variable in cache-l2x0.c should
> be renamed from CACHE_LINE_SIZE to CACHE_BLOCK_SIZE
> if we go with that terminology, right? That is the real change that
> is needed to make terminology consistent then.

Not sure if it's worth it. It may be a case of IBM terminology being
at odds with ARM terminology. ;-)

	Arnd
