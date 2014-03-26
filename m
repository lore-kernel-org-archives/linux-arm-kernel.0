From: tj@kernel.org (Tejun Heo)
Date: Wed, 26 Mar 2014 12:29:41 -0400
Subject: [PATCH] ata: fix Marvell SATA driver dependencies
In-Reply-To: <5138028.BSQbEP7RRB@amdc1032>
References: <5138028.BSQbEP7RRB@amdc1032>
Message-ID: <20140326162941.GH7171@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 05:19:02PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Make sata_mv host driver depend on PCI || ARCH_KIRKWOOD || ARCH_MVEBU ||
> ARCH_ORION5X config options as Marvell SATA support covers both Marvell
> PCI devices and Marvell Kirkwood, Armada 370/XP and Orion5x SoCs (for
> non-PCI devices the driver to work requires suitable device tree node to
> be defined).  Additionally allow the driver build if COMPILE_TEST config
> option is set.
> 
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Patch doesn't apply to libata/for-3.15.

Thanks.

-- 
tejun
