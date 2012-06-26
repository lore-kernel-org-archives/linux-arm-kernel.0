From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 26 Jun 2012 08:58:42 +0000
Subject: [PATCH v6 00/13] GPMC driver conversion
In-Reply-To: <cover.1340367480.git.afzal@ti.com>
References: <cover.1340367480.git.afzal@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99F0D2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Fri, Jun 22, 2012 at 18:25:38, Mohammed, Afzal wrote:

> This series is based on 3.5-rc1, and is dependent on [1,2,3], and has
> been tested on omap3evm (smsc911x) rev G & C and beagle board(nand).
> Also using private patches, nand & onenand was tested on omap3evm,
> rev G & C respectively (as support for these were not in mainline)
> 
> All boards will work using the old existing interface. Further patch
> series would convert all boards to use new interface.
> 
> Many of GPMC peripherals depend on bootloader for configuration.
> This is going to be deprecated. feature-removal-schedule.txt will be
> updated in one of the upcoming patch series.
> 
> Thanks to Tony & Jon for their various suggestions.
> 
> [PATCH 03/13] ARM: OMAP2+: gpmc: driver migration helper, is to be
> reverted once all GPMC peripherals are migrated to use driver
> interface.

Please let me know your comments on this series.

Regards
Afzal
