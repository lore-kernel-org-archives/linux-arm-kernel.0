From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Mar 2015 16:53:47 +0100
Subject: Thermal: Cleanups, fixes and hardware trip points
Message-ID: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for hardware trip points. It picks up earlier
work from Mikko Perttunen. Mikko implemented hardware trip points as part
of the device tree support. It was suggested back then to move the
functionality to the thermal core instead of putting more code into the
device tree support. This series does exactly that.

The majority of the patches are cleanups and fixes. Only the last two
patches actually implement the hardware trip points.

All comments welcome

Sascha
