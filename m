From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 15 Mar 2013 13:27:36 +0100
Subject: [PATCH 5/6] ARM: kill Hynix h720x platform
In-Reply-To: <1363299178-8241-6-git-send-email-arnd@arndb.de>
References: <1363299178-8241-1-git-send-email-arnd@arndb.de>
 <1363299178-8241-6-git-send-email-arnd@arndb.de>
Message-ID: <20130315132736.10a864b8@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Thu, 14 Mar 2013 23:12:57 +0100, Arnd Bergmann wrote:
> The platform was merged about 10 years ago, and has seen few updates
> for most of the time since. The people that merged the code seem
> no longer interested in it either, so let's remove it now.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Robert Schwebel <r.schwebel@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>

If this gets removed, then presumably drivers/mtd/maps/h720x-flash.c
should be removed as well.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
