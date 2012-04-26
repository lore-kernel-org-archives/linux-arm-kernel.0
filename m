From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 26 Apr 2012 05:21:45 +0000
Subject: [TMP] OMAP3EVM: Test gpmc nand & smsc911x
In-Reply-To: <20120425164726.GU3739@atomide.com>
References: <cover.1333640054.git.afzal@ti.com>
 <bb95fec60401f7cf6ac77200a12baf3fc83852f5.1333640054.git.afzal@ti.com>
 <20120425164726.GU3739@atomide.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E970122@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wed, Apr 25, 2012 at 22:17:26, Tony Lindgren wrote:
> Obviously we can't merge any of this if until all the board-*.c files
> are changed and tested.
> 
> Can you maybe still keep the old interfaces in addition to the new ones
> so we can do the conversion one board-*.c file at a time while keeping
> things working?

As there are peripherals using helper functions, to handle those, you
meant to create a new altered similar function to deal for each too ?,
while keeping existing functions as such.

i.e. like having gpmc_smsc911x_init & gpmc_smsc911x_new_init for
each peripheral ?, with gpmc_smsc911x_new_init using gpmc driver,
and gpmc_smsc911x_init as is.

Regards
Afzal
