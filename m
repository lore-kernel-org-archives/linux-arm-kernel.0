From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Sep 2012 10:10:54 -0700
Subject: [PATCH 04/29] ARM: OMAP1: Move board-ams-delta.h from plat to mach
In-Reply-To: <6194989.y5R5mbkCAc@acer>
References: <20120919205732.28074.43697.stgit@muffinssi>
 <20120919210543.28074.10214.stgit@muffinssi>
 <6194989.y5R5mbkCAc@acer>
Message-ID: <20120920171054.GA28835@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [120920 06:48]:
> On Wed, 19 Sep 2012 14:05:43 Tony Lindgren wrote:
> > This is only used by omap1.
> > 
> > And to fix things properly, this should not be included
> > from the drivers at all.
> 
> Akced-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> 
> I'll take care of updating the drivers when I have some spare time.

Thanks those can be fixed by passing them in the platform data.

Regards,

Tony
