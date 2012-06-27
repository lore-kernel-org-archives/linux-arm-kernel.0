From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 27 Jun 2012 10:08:02 +0000
Subject: [PATCH v5 0/3] Prepare for GPMC driver conversion
In-Reply-To: <cover.1340778002.git.afzal@ti.com>
References: <cover.1340778002.git.afzal@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99FA70@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wed, Jun 27, 2012 at 12:03:07, Mohammed, Afzal wrote:

> Objective of this series is to make things easy for GPMC driver
> conversion series by separating out more things from driver
> conversion series.
> 
> This series,
> 1. Unifies NAND platform initialization functions
> 2. Prepares OneNAND platform code for gpmc driver migration
> 3. Handles additional timings in Kernel
> 
> This series is based on 3.5-rc1 & made on top of
> [PATCH v2 00/10] Prepare for GPMC driver conversion (w.r.t MTD)
> {http://www.mail-archive.com/linux-omap at vger.kernel.org/msg70096.html}
> 
> These changes has been tested with omap3evm & beagle board. Relevant
> GPMC peripherals that got tested by this were NAND (beagle) and
> OneNAND (using local patches for omap3evm)

All of Jon's comments in this series has been taken care and has
Reviewed-by from him on 2 patches, can you please take this series

Regards
Afzal
