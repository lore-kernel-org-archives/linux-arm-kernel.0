From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Dec 2013 10:43:49 -0800
Subject: [GIT PULL] make mach-omap2 boot with device tree only for v3.14
In-Reply-To: <201312101936.54483.arnd@arndb.de>
References: <pull-1386643347-596413>
 <20131210143547.GA32243@n2100.arm.linux.org.uk>
 <20131210160144.GG13171@atomide.com>
 <201312101936.54483.arnd@arndb.de>
Message-ID: <20131210184349.GM13171@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [131210 10:38]:
> On Tuesday 10 December 2013, Tony Lindgren wrote:
> > The crappy part here is the fact that we need to build the kernel with
> > appended DTB. Maybe there's something more we can do to make it easier.
> > 
> 
> You are aware of the impedence matcher project [1], right?

Oh OK cool :) AFAIK the only omaps we're currently supporting in the
mainline tree where the bootloader cannot be updated easily are the
n9* that require a signed bootloader. But I think those already have
some kind of 3rd stage bootloaders available for them.

Regards,

Tony
 
> [1] https://github.com/zonque/pxa-impedance-matcher
