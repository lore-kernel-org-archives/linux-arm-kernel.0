From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 22 Mar 2017 16:57:07 +0000
Subject: [PATCH] [v2] arm64: define BUG() instruction without CONFIG_BUG
In-Reply-To: <CAK8P3a1V37QGtB6EeXptaOgKFz1QE=VObN91r1Ld-0ZOKAPXaQ@mail.gmail.com>
References: <20170314213939.3874497-1-arnd@arndb.de>
 <20170322143729.GB25645@e104818-lin.cambridge.arm.com>
 <CAK8P3a0A0-gnBnBBuWdPjgoDMo=2P9yXcLjZYm9Yz+xpQnCyCw@mail.gmail.com>
 <20170322153208.GC25645@e104818-lin.cambridge.arm.com>
 <CAK8P3a1V37QGtB6EeXptaOgKFz1QE=VObN91r1Ld-0ZOKAPXaQ@mail.gmail.com>
Message-ID: <20170322165706.GE25645@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 05:29:19PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 22, 2017 at 4:32 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Wed, Mar 22, 2017 at 03:51:54PM +0100, Arnd Bergmann wrote:
> >> On Wed, Mar 22, 2017 at 3:37 PM, Catalin Marinas
> >> <catalin.marinas@arm.com> wrote:
> 
> >> Taht was certainly not intended, and I don't see yet what exactly is going on.
> >> What is your setting for CONFIG_BUG and CONFIG_BUGVERBOSE?
> >
> > CONFIG_BUG=y
> > CONFIG_DEBUG_BUGVERBOSE=y
> 
> Ok, I found the typo, can you just fold this in, or should I send an
> updated patch?

I'll fold it in. Thanks.

-- 
Catalin
