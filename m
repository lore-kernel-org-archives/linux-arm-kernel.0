From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Sun, 28 May 2017 13:30:25 +0300
Subject: [PATCH v3 0/1] orange-pi-zero: minor updates for peripherals
Message-ID: <20170528103026.6396-1-geomatsi@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds optional node for SPI NOR chip on the orange-pi-zero board.

Changes from v2:
- add new node in alphabetical order
- drop changes for wifi xr819 node for the time being:
  -- more work is needed, e.g. adding bindings for XR819

Changes from v1:
- update commit messages: drop links to wiki at linux-sunxi.org
- disable SPI NOR flash by default
- drop description of the flash partitions
- add compatible property for XR819 wifi node

sun8i-h2-plus-orangepi-zero.dts |   13 +++++++++++++
1 file changed, 13 insertions(+)
