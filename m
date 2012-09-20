From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Thu, 20 Sep 2012 15:41:45 +0200
Subject: [PATCH 04/29] ARM: OMAP1: Move board-ams-delta.h from plat to mach
In-Reply-To: <20120919210543.28074.10214.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
 <20120919210543.28074.10214.stgit@muffinssi>
Message-ID: <6194989.y5R5mbkCAc@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Sep 2012 14:05:43 Tony Lindgren wrote:
> This is only used by omap1.
> 
> And to fix things properly, this should not be included
> from the drivers at all.

Akced-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

I'll take care of updating the drivers when I have some spare time.

Thanks,
Janusz
