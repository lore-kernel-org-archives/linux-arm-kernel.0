From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 17 Feb 2014 15:13:34 -0500
Subject: irqchip: irq-dove: problem with the PMU interrupt controller.
In-Reply-To: <20140209082247.GD29203@lunn.ch>
References: <20140209091016.26a59d44@armhf>
 <20140209082247.GD29203@lunn.ch>
Message-ID: <20140217201334.GZ7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 09, 2014 at 09:22:47AM +0100, Andrew Lunn wrote:
> On Sun, Feb 09, 2014 at 09:10:16AM +0100, Jean-Francois Moine wrote:
> > Hi Andrew,
> > 
> > I have a WARN_ON at system startup time of the Cubox (Marvell Dove).
> > Sorry for I don't know enough about the IRQ subsystem to fix it.
> 
> Hi Jean-Francois
> 
> The DT node made it into -rc1, but the driver itself was forgotten by
> the IRQ maintainer. It will hopefully appear in -rc2.

Unfortunately, this didn't happen.  I've posted a patch to revert adding
the DT node for v3.14.  It'll be re-added in conjunction with the driver
code.  Hopefully for v3.15.

  http://www.spinics.net/lists/arm-kernel/msg308413.html

Please test and let me know if that fixes the WARN_ON.

thx,

Jason.
