From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 12 Jun 2012 10:39:56 +0000
Subject: [PATCH v5 00/14] GPMC driver conversion
In-Reply-To: <cover.1339419492.git.afzal@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E998065@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Mon, Jun 11, 2012 at 19:55:02, Mohammed, Afzal wrote:
> Hi,
> 
> This series is based on 3.5-rc1, and is dependent on [1,2,3]
> 
> This series has been tested on omap3evm (smsc911x) rev G & C and
> beagle board(nand) using patch series which is going to be posted
> shortly (this series only creates a driver out of GPMC code)
> 
> Also using private patches, nand & onenand was tested on omap3evm,
> rev G & C respectively (as support for these were not in mainline)
> 
> Many of GPMC peripherals depend on bootloader for configuration.
> This is going to be deprecated. feature-removal-schedule.txt will be
> updated in one of the upcoming patch series regarding the same.
> 
> 
> [PATCH 03/13] ARM: OMAP2+: gpmc: driver migration helper, is to be
> reverted once all GPMC peripherals are migrated to use driver
> interface.

Please let me know your comments on this series. I had tried to
go as per your requirements.

This series keeps old interface while providing a new driver interface.
Old interface will work (to the best of my knowledge; omap3evm &
beagle are the ones available here to test) at each of the commits.

Regards
Afzal
