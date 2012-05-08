From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 8 May 2012 11:27:58 +0000
Subject: [PATCH v4 00/39] OMAP GPMC driver conversion
In-Reply-To: <cover.1335874494.git.afzal@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E987D39@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Tue, May 01, 2012 at 17:49:03, Mohammed, Afzal wrote:
> GPMC driver conversion patch series. Some peripherals has GPMC helper
> functions, these has been modified to cater to the needs of GPMC
> driver. All the boards using GPMC has been adapted to use the new
> GPMC driver.
> 
> GPMC HWMOD entry for OMAP2/3 has been added. On OMAP3, kernel does
> spit "omap_hwmod: gpmc: cannot be enabled for reset (3)", but
> peripherals connected via GPMC are working. Really shaky about OMAP2
> GPMC HWMOD entry. Would be helpful if someone can help me in resolving
> warning on OMAP3 & verify whether OMAP2 entry is proper. The series
> adapts to HWMOD.
> 
> Drivers, NAND & OneNAND of OMAP has been modified to make use of GPMC
> changes & cleaned up the now unnecessary exported symbol usages.
> 
> This series has been made on top of,
> 5e136da Linux-omap rebuilt: Updated to -rc5,
> A patch by Javier Martinez Canillas <javier@dowhile0.org>,
> OMAP3: igep0020: Add support for Micron NAND Flash storage memory,
> has also been incorporated into the series as this was necessary for
> igep0020 board.
> 
> This has been tested on omap3 evm (SMSC911x) & beagle board (NAND)


Please let me know your comments on this series.

Regards
Afzal
