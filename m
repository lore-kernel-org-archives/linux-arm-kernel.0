From: jason@lakedaemon.net (Jason)
Date: Mon, 27 Feb 2012 12:31:28 -0500
Subject: [PATCH 0/2 v6] arm: kirkwood: add dreamplug/devicetree support
In-Reply-To: <201202271629.37478.arnd@arndb.de>
References: <cover.1312906908.git.jason@lakedaemon.net>
 <cover.1330358323.git.jason@lakedaemon.net>
 <201202271629.37478.arnd@arndb.de>
Message-ID: <20120227173128.GW23524@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 04:29:37PM +0000, Arnd Bergmann wrote:
> On Monday 27 February 2012, Jason Cooper wrote:
> > This patch series provides initial support for devicetree on kirkwood for the
> > dreamplug platform.  After discussing the approach with Arnd Bergman last week
> > at ELC, we decided to take an incremental approach to the conversion.  First, I
> > would detect that we were on the dreamplug via the devicetree blob.  Then,
> > configure uart0 via devicetree.  We chose the uart since it is already well
> > supported under devicetree.
> > 
> > This patch series has been boot-tested on the dreamplug.
> > 
> > In a future patch series, I plan to migrate spi/flash/partitions over to
> > devicetree.
> > 
> > When the migration is complete, board-dt.c will not be specific to the
> > dreamplug, and dts files can be written for all of the other kirkwood boards.
> > 
> > Jason Cooper (2):
> >   arm: kirkwood: add dreamplug (fdt) support.
> >   arm: kirkwood: convert uart0 to devicetree.
> 
> Applied to the kirkwood/board branch and pulled into next/boards.
> 
> Great work!

Well, that was easier than I thought.  Thanks.

> I've made two trivial manual changes, please do these yourself next time:
> 
> 1. Subject should start with "ARM: kirkwood:", not "arm: kirkwood:" by
>    convention.

Sorry, will do.

> 2. Nico and I had both replied with "Acked-by:". When you get one of
>    these replies, add that line under your "Signed-off-by:" line.

Ahh, I always wondered how those made the transition.  Will add that to
my process.

> If you have more changes for dreamplug, please submit those on top of
> these patches now.

Okay, SPI coming up next.

thx,

Jason.
