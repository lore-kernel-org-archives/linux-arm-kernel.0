From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Nov 2012 14:21:31 +0000
Subject: [PATCH V6 3/6] arm: cache-l2x0: add support for Aurora L2
 cache ctrl
In-Reply-To: <201211081408.41983.arnd@arndb.de>
References: <CAHkRjk7YdzB_RMCjY7SkzPVwEvuk17akJxaNeNmAuqZpwX_kfQ@mail.gmail.com>
 <20121023090154.GP21164@n2100.arm.linux.org.uk>
 <508666A6.9040701@free-electrons.com> <201211081408.41983.arnd@arndb.de>
Message-ID: <20121108142131.GA28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 08, 2012 at 02:08:41PM +0000, Arnd Bergmann wrote:
> The newly introduced l2_wt_override should be in the same #ifdef
> as the code using it, otherwise we get:
> 
> arch/arm/mm/cache-l2x0.c:37:12: warning: 'l2_wt_override' defined but not used

This should already be fixed.  I think your patch pre-dates 7547/4.
