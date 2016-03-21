From: xypron.glpk@gmx.de (Heinrich Schuchardt)
Date: Mon, 21 Mar 2016 16:17:30 +0100
Subject: sunxi-mmc.c: timed out sending r/w cmd command
Message-ID: <56F0108A.8080004@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am running kernel v4.5 on an Merrii Optimusboard (Allwinner A80).

Messages like the following are written in 3 to 15 second intervals
while copying files to a micro SDHC card.

[ 1670.055412] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 25, WR EBE !!
[ 1670.061468] sunxi-mmc 1c0f000.mmc: data error, sending stop command
[ 1670.068250] mmcblk0: timed out sending r/w cmd command, card status 0x900
[ 1670.139125] mmc0: tried to reset card

Best regards

Heinrich Schuchardt
