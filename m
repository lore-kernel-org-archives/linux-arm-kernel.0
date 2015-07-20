From: eric@anholt.net (Eric Anholt)
Date: Mon, 20 Jul 2015 12:32:59 -0700
Subject: [PATCH v4 0/8] Raspberry Pi clock support
Message-ID: <1437420787-32137-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a respin of my rpi-dt-clocks series (also available at
https://github.com/anholt/linux/tree/rpi-dt-clocks).  New in this
version is mentioning the clk subsystem for drivers/clk/* patches,
some better documentation of behavior in clk-raspberrypi.c, and a new
patch at the tail of the series for updating the EMMC clock.
