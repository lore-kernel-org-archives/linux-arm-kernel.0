From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 29 Jun 2018 13:50:59 +1000
Subject: [PATCH 0/7] arm: Aspeed DT & config updates for USB
Message-ID: <20180629035106.27181-1-benh@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the device-tree of the Aspeed SoC to better define
the pinmux for the USB host and to add the missing "Virtual Hub"
USB device.

We also enable USB device in the defconfigs and configure a
port as device on the evaluation board.
