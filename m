From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2011 11:15:55 +0100
Subject: [PATCH 0/2] Add runtime PM support to Primecell bus
Message-ID: <20110823101555.GE19622@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add basic runtime PM support to the Primecell bus type, so
that the bus clock can be managed according to the activities of devices
attached to it.

The inspiration of the bus level implementation was taken from PCI,
originally written by Rafael.

Adding the bus level runtime PM support requires removing the runtime PM
setup/teardown from the SPI driver, hence why the SPI driver features in
patch 1.

Patch 2 adds runtime PM support to the MMC interface driver.

Please can I have acks for these two patches.  It's likely that they will
depend on other ARM work.

Thanks.
