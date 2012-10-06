From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 6 Oct 2012 09:55:39 +0100
Subject: [PATCH] ARM: pxa: Fix build error caused by sram.h rename
In-Reply-To: <201210051857.01311.arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <201210022027.45461.arnd@arndb.de>
 <87d30xgel3.fsf@octavius.laptop.org>
 <201210051857.01311.arnd@arndb.de>
Message-ID: <20121006085539.GC8590@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2012 at 06:57:00PM +0000, Arnd Bergmann wrote:
> On Friday 05 October 2012, Chris Ball wrote:

> > Thanks.  Do you want to send this to mainline, or should Mark do it?

> I think it's better for Mark to queue it up than me. sound/soc/
> is his domain, and I don't have any other patches that would go
> along with this fix.

Can someone send me the patch please (possibly with a slightly smaller
CC list)?
