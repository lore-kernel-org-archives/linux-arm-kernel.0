From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 26 Mar 2014 18:35:17 +0100
Subject: [PATCH v2] ata: fix Marvell SATA driver dependencies
In-Reply-To: <3641258.OaO7lhnDYy@amdc1032>
References: <3641258.OaO7lhnDYy@amdc1032>
Message-ID: <20140326173517.GI25349@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 05:59:03PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Make sata_mv host driver depend on PCI || ARCH_KIRKWOOD || ARCH_MVEBU ||
> ARCH_ORION5X config options as Marvell SATA support covers both Marvell
> PCI devices and Marvell Kirkwood, Armada 370/XP and Orion5x SoCs 

I would of thought Dove and mv78xx0 would also want it.

     Andrew
