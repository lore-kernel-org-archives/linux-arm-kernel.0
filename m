From: tony@atomide.com (Tony Lindgren)
Date: Fri, 3 May 2013 14:04:46 -0700
Subject: [PATCH 7/9] ARM: OMAP: don't select SERIAL_OMAP unconditionally
In-Reply-To: <201305032234.30974.arnd@arndb.de>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
 <1367528578-518090-8-git-send-email-arnd@arndb.de>
 <20130502233249.GU28721@atomide.com>
 <201305032234.30974.arnd@arndb.de>
Message-ID: <20130503210446.GX28721@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130503 13:40]:
> On Friday 03 May 2013, Tony Lindgren wrote:
> > Please just drop this and pick my earlier fix instead:
> > 
> > [PATCH 1/3] ARM: OMAP2+: Fix unmet direct dependencies for SERIAL_OMAP
> > 
> > Or let me know if you prefer me to queue it.
> 
> I've applied your patch now. Should I also take the other two of that
> series? I was not on Cc for these patches, but all three seem to be
> required still.

Yes go for it. Note that the two other patches have dependencies to
branches for the current merge window, but you probably already 
have some base they can be applied against.

Regards,

Tony
