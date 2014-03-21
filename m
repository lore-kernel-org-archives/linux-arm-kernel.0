From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Mar 2014 16:46:08 +0100
Subject: [PATCH 01/62] ARM: at91: split out at91x40 into a top-level option
In-Reply-To: <532AA8F6.7060003@atmel.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-2-git-send-email-arnd@arndb.de>
 <532AA8F6.7060003@atmel.com>
Message-ID: <201403211646.08478.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014, Nicolas Ferre wrote:
> On 19/03/2014 20:28, Arnd Bergmann :
> > at91x40 is different from all the other at91 machines, and it is
> > impossible to build a kernel that works on both this SoC and
> > any of the others, even though it is possible to build a noMMU
> > kernel for any at91 machine.
> > 
> > By turning at91x40 into a separate top-level option, we explicitly
> > forbid enabling invalid configurations that include mutually exclusive
> > machines.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Andrew Victor <linux@maxim.org.za>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> I added below little modifications to the comments, now that the AT91X40
> is another entry.
> 
> Otherwise:
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Changed now, thanks for the suggestion!

	Arnd
