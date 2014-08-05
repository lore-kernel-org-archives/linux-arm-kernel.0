From: arnab.basu@freescale.com (Arnab Basu)
Date: Tue, 5 Aug 2014 18:56:42 +0530
Subject: Regarding CONFIG_BLK_DEV_RAM and CONFIG_BLK_DEV_RAM_SIZE in
 arch/arm64/configs/defconfig
Message-ID: <53E0DB92.2030609@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

While trying to boot Linux with an initrd I found that 
CONFIG_BLK_DEV_RAM and CONFIG_BLK_DEV_RAM_SIZE are not part of the arm64 
defconfig. Is this because no one has got around to adding them or is 
this something that has been omitted on purpose?

Thanks
Arnab
