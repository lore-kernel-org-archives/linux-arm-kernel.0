From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 22 Feb 2012 16:17:21 -0500 (EST)
Subject: [PATCH 2/3 v4] arm: kirkwood: add dreamplug (fdt) support.
In-Reply-To: <201202222046.28707.arnd@arndb.de>
References: <cover.1329936660.git.jason@lakedaemon.net>
 <8532afcdc4adbb3771e6f742bcc33ef9c0347858.1329936660.git.jason@lakedaemon.net>
 <201202222046.28707.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1202221614560.24536@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Feb 2012, Arnd Bergmann wrote:

> On Wednesday 22 February 2012, Jason Cooper wrote:
> > Initially, copied guruplug-setup.c and did s/guruplug/dreamplug/g.
> > Then, switched to SPI based NOR flash.
> > 
> > After talking to Arnd Bergman, chose an incremental approach to adding
> > devicetree support.  First, we use the dtb to tell us we are on the
> > dreamplug, then we gradually port over drivers.
> > 
> > Driver porting will start with the uart (see next patch), and progress
> > from there.  Possibly, spi/flash/partitions will be next.
> > 
> > When done, board-dt.c will no longer be dreamplug specific, and dt's can
> > be made for the other kirkwood boards.
> > 
> > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> 
> Looks good to me. 
> 
> I'm adding Nicolas and Lennert to Cc to make sure they see the mail.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

I'm fine with the approach.

Acked-by: Nicolas Pitre <nico@linaro.org>

Arnd, Jason: please feel free to work something out between yourselves 
to move those patches into the arm-soc tree.


Nicolas
