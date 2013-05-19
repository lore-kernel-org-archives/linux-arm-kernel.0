From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 19 May 2013 17:13:14 +0200
Subject: [PATCH 0/4] ARM: Remove boilerplate debug_ll_io_init code
In-Reply-To: <201305171531.16240.arnd@arndb.de>
References: <1368440169-29088-1-git-send-email-maxime.ripard@free-electrons.com>
 <201305160040.54399.arnd@arndb.de>
 <5194F944.2040803@free-electrons.com>
 <201305171531.16240.arnd@arndb.de>
Message-ID: <20130519151314.GA7717@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, May 17, 2013 at 03:31:16PM +0200, Arnd Bergmann wrote:
> On Thursday 16 May 2013, Maxime Ripard wrote:
> 
> > 
> > How will we merge this? The first patch would be merged by Russel and
> > the 3 others by their respective maintainers?
> 
> I think since it's mostly platform code and all trivial, we can merge
> it into the next/cleanup branch in arm-soc directly.

Ok, then I can probably merge it into the branch with the irqchip_init
patches and send both these cleanups into the same branch in a few
weeks?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
