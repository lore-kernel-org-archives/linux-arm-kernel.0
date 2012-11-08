From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Nov 2012 14:42:15 +0000
Subject: [PATCH V6 3/6] arm: cache-l2x0: add support for Aurora L2 cache
 ctrl
In-Reply-To: <20121108142131.GA28327@n2100.arm.linux.org.uk>
References: <CAHkRjk7YdzB_RMCjY7SkzPVwEvuk17akJxaNeNmAuqZpwX_kfQ@mail.gmail.com>
 <201211081408.41983.arnd@arndb.de>
 <20121108142131.GA28327@n2100.arm.linux.org.uk>
Message-ID: <201211081442.15390.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 November 2012, Russell King - ARM Linux wrote:
> On Thu, Nov 08, 2012 at 02:08:41PM +0000, Arnd Bergmann wrote:
> > The newly introduced l2_wt_override should be in the same #ifdef
> > as the code using it, otherwise we get:
> > 
> > arch/arm/mm/cache-l2x0.c:37:12: warning: 'l2_wt_override' defined but not used
> 
> This should already be fixed.  I think your patch pre-dates 7547/4.

Yes, that's right. I was looking at yesterday's linux-next. It's fixed today.

Thanks,

	Arnd
