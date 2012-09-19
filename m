From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Sep 2012 14:58:00 +0000
Subject: [PATCH 1/1] drivers: bus: Move the OMAP interconnect driver to
 drivers/bus/
In-Reply-To: <20120917215128.GF11762@atomide.com>
References: <1347614434-15938-1-git-send-email-santosh.shilimkar@ti.com>
 <20120917215128.GF11762@atomide.com>
Message-ID: <201209191458.00531.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 September 2012, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [120914 02:21]:
> > OMAP interconnect drivers are used for the interconnect error handling.
> > Since they are bus driver, lets move it to newly created drivers/bus.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> > Patch just moves OMAP interconnect drivers as is to the newly created
> > driver/bus/* directory. Patch is generated against "arm-soc/drivers/ocp2scp"
> > tree and test on all OMAP boards.
> 
> Great, looks like this should not conflict with other
> omap patches queued, so Arnd should probably take this into
> the bus branch:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Ok, added to the branch. In the future please Cc both Olof and me when submitting
patches for inclusion.

Olof: I figured it would be easier if I just add this one than relaying it to
you.

	Arnd
