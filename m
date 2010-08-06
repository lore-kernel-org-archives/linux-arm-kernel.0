From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  6 Aug 2010 15:53:03 +0200
Subject: Add i.MX51 support to mxc_nand
Message-ID: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The following series adds v3 (found on i.MX51) support to the i.MX nand
controller. auto mode is not supported, but if I understand correctly
the auto mode is only of use when more than one nand chip is connected.
Without the auto mode the v3 controller behaves very similar to the v2
controller, but unfortunately it has a completely different register
layout. For this reason this series has some preparation patches before
the v3 support is added as the last patch.

This series conflicts with the series John Ogness recently posted, so
it has probably to be reworked a bit.

I'll post the nand platform support for i.MX51 in a seperate series.

Sascha
