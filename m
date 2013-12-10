From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Dec 2013 19:36:54 +0100
Subject: [GIT PULL] make mach-omap2 boot with device tree only for v3.14
In-Reply-To: <20131210160144.GG13171@atomide.com>
References: <pull-1386643347-596413>
 <20131210143547.GA32243@n2100.arm.linux.org.uk>
 <20131210160144.GG13171@atomide.com>
Message-ID: <201312101936.54483.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 December 2013, Tony Lindgren wrote:
> The crappy part here is the fact that we need to build the kernel with
> appended DTB. Maybe there's something more we can do to make it easier.
> 

You are aware of the impedence matcher project [1], right?

	Arnd

[1] https://github.com/zonque/pxa-impedance-matcher
