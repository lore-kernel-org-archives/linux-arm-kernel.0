From: davem@davemloft.net (David Miller)
Date: Thu, 03 Mar 2016 17:22:22 -0500 (EST)
Subject: [PATCH 2/2] isdn: i4l: move active-isdn drivers to staging
In-Reply-To: <1456945629-1793533-2-git-send-email-arnd@arndb.de>
References: <1456945629-1793533-1-git-send-email-arnd@arndb.de>
 <1456945629-1793533-2-git-send-email-arnd@arndb.de>
Message-ID: <20160303.172222.338748622348351793.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed,  2 Mar 2016 20:06:46 +0100

> The icn, act2000 and pcbit drivers are all for very old hardware,
> and it is highly unlikely that anyone is actually still using them
> on modern kernels, if at all.
> 
> All three drivers apparently are for hardware that predates PCI
> being the common connector, as they are ISA-only and active
> PCI ISDN cards were widely available in the 1990s.
> 
> Looking through the git logs, it I cannot find any indication of a
> patch to any of these drivers that has been tested on real hardware,
> only cleanups or global API changes.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Greg, can you please take these two patches?

Thanks!
