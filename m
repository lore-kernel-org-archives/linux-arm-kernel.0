From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Mar 2012 08:20:08 +0000
Subject: [PATCH] ARM: OMAP2+: gpmc-smsc911x: only register regulator for
 first instance
In-Reply-To: <20120319224858.GD9859@atomide.com>
References: <1331080771-30687-1-git-send-email-khilman@ti.com>
 <201203192209.43906.arnd@arndb.de> <20120319224858.GD9859@atomide.com>
Message-ID: <201203200820.08471.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 March 2012, Tony Lindgren wrote:
> Let's just keep bb60424af. There are more patches needed to make
> multiple smsc91x instances work, but we need to hear from people
> with such boards first. Then those can be tagged for stable.
> 

Ok, I'm just putting that into the fixes branch for 3.4 then.

Thanks,

	Arnd
