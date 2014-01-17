From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Fri, 17 Jan 2014 13:07:13 +0530
Subject: Kconfig errors
Message-ID: <CA+V-a8vcvTRpP-cE6SKd1KgWgzSbOXvSNW+5Jh8wqOfr1za4SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Linux-next branch I see following errors for davinci_all_defconfig
& da8xx_omapl_defconfig configs,

arch/arm/Kconfig:1966:error: recursive dependency detected!
arch/arm/Kconfig:1966:    symbol ZBOOT_ROM depends on AUTO_ZRELADDR
arch/arm/Kconfig:2154:    symbol AUTO_ZRELADDR is selected by ZBOOT_ROM
#
# configuration written to .config
#

Regards,
--Prabhakar Lad
