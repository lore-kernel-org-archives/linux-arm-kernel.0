From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 Apr 2013 19:40:12 +0200
Subject: [GIT PULL 2/3] omap timer changes for v3.10 merge window
In-Reply-To: <0LdWUM-1V6HSB0nzO-00i0Xm@mx.kundenserver.de>
References: <0LdWUM-1V6HSB0nzO-00i0Xm@mx.kundenserver.de>
Message-ID: <201304081940.12773.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 April 2013, Tony Lindgren wrote:
>  arch/arm/mach-omap2/board-cm-t3517.c |   2 +-
>  arch/arm/mach-omap2/board-generic.c  |   2 +-
>  arch/arm/mach-omap2/common.h         |   3 +-
>  arch/arm/mach-omap2/timer.c          | 124 ++++++++++++++++++-----------------
>  4 files changed, 66 insertions(+), 65 deletions(-)

BTW, do you have any plans to move the timer.c file to drivers/clocksource?

I think that's where most of them are heading now.

	Arnd
