From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 21 Dec 2013 17:41:51 +0100
Subject: Openblocks AX3-4 i2c bus lockup
Message-ID: <20131221164151.GF20115@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nobuhiro

You added I2C into the Openblocks AX3-4 device tree and the subnode
for the RTC. Did you have any problems with I2C? I'm having lots of
problems with my AX3-4 and i2c. I get i2c errors and the bus being
locked and then the whole machine locks solid.

Gregory, did you test your I2C patches for 370/XP on an Openblocks
AX3-4?

Thanks
	Andrew
