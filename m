From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 8 Mar 2013 22:12:23 -0500
Subject: [PATCH] ARM: Dove: add RTC device node
In-Reply-To: <201303082312.02189.arnd@arndb.de>
References: <20130308121317.4ee83c0a@armhf>
 <20130308215818.GU23237@titan.lakedaemon.net>
 <201303082312.02189.arnd@arndb.de>
Message-ID: <20130309031223.GX23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 11:12:02PM +0000, Arnd Bergmann wrote:
> On Friday 08 March 2013, Jason Cooper wrote:
> > Applied to mvebu/fixes with the following commit entry:
> > 
> >     ARM: Dove: add RTC device node
> > 
> >     The commit:
> > 
> >       48be9ac ARM: Dove: split legacy and DT setup
> > 
> >     removed the RTC initialization.  This patch re-enables the RTC
> >     via the DT.
> 
> Looks good. FWIW, the style I tend to use is
> 
> 
> |ARM: Dove: add RTC device node
> |
> |The commit 48be9ac "ARM: Dove: split legacy and DT setup" removed the RTC
> |initialization.  This patch re-enables the RTC via the DT.
> 
> I don't think that there is a wide agreement on how to refer to other
> patches yet, but I do a lot of regression fixes like that, so maybe I
> can start a trend here.

Looks good to me.  flows a bit better than what I had.  I'll use that
from now on for anything I come across.

thx,

Jason.
