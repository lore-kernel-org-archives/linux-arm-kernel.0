From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 May 2013 22:34:30 +0200
Subject: [PATCH 7/9] ARM: OMAP: don't select SERIAL_OMAP unconditionally
In-Reply-To: <20130502233249.GU28721@atomide.com>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
 <1367528578-518090-8-git-send-email-arnd@arndb.de>
 <20130502233249.GU28721@atomide.com>
Message-ID: <201305032234.30974.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 May 2013, Tony Lindgren wrote:
> Please just drop this and pick my earlier fix instead:
> 
> [PATCH 1/3] ARM: OMAP2+: Fix unmet direct dependencies for SERIAL_OMAP
> 
> Or let me know if you prefer me to queue it.

I've applied your patch now. Should I also take the other two of that
series? I was not on Cc for these patches, but all three seem to be
required still.

	Arnd
