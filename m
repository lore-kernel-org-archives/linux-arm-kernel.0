From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 19 Feb 2014 19:25:43 +0000 (UTC)
Subject: [PATCH 1/2] ARM: OMAP2+: fix rate prints
In-Reply-To: <1389944699-27962-2-git-send-email-tomi.valkeinen@ti.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
 <1389944699-27962-2-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <alpine.DEB.2.02.1402191924520.8777@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Jan 2014, Tomi Valkeinen wrote:

> Printing with unsigned long rates with %ld gives wrong result if the
> rate is high enough. Fix this by using %lu.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, queued for v3.15. 

There's a series here that converts the OMAP clock code away from signed 
longs for clock rates that was originally intended for v3.14, but it's 
been delayed.


- Paul
