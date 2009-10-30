From: mark.retallack@siemens.com (Retallack, Mark)
Date: Fri, 30 Oct 2009 09:47:06 +0100
Subject: At91SAM9G20 AT91_MCI patches
Message-ID: <5547BA931CA43849A16B2B02F2528D3938F80DD6@DEFTHW99E25MSX.ww902.siemens.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good morning, I hope this is the correct list. 

I am using the AT91SAM9G20-EK dev board. It does not look like the vanilla kernel (2.6.27+) contains the patch for support in the drivers/mmc/host/at91_mci.c file. Patch 5130/3 contains the correct information, however the final patch 5130/4 has the at91_mci section removed. Was there a reason for this? 

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5130/3
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5130/4

Also it would be useful to know what the preferred MCI (MMC) driver for the AT91SAM9G20 is; the at91_mci or atmel_mci. The revision A and B AT91SAM9G20-EK dev board (board-sam9g20ek.c) uses the at91_mci driver, but the revision C AT91SAM9G20-EK dev board (board-sam9g20ek-2slot-mmc.c) uses atmel_mci driver.

Thanks in advance 

Mark Retallack.
