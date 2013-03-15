From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 16:12:27 +0000
Subject: [PATCH 5/6] ARM: kill Hynix h720x platform
In-Reply-To: <20130315132736.10a864b8@skate>
References: <1363299178-8241-1-git-send-email-arnd@arndb.de>
 <1363299178-8241-6-git-send-email-arnd@arndb.de>
 <20130315132736.10a864b8@skate>
Message-ID: <201303151612.27618.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013, Thomas Petazzoni wrote:
> On Thu, 14 Mar 2013 23:12:57 +0100, Arnd Bergmann wrote:
> > The platform was merged about 10 years ago, and has seen few updates
> > for most of the time since. The people that merged the code seem
> > no longer interested in it either, so let's remove it now.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Robert Schwebel <r.schwebel@pengutronix.de>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> 
> If this gets removed, then presumably drivers/mtd/maps/h720x-flash.c
> should be removed as well.

Correct, see patch 6.

	Arnd
