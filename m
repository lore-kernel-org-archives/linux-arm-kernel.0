From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 26 Jul 2011 16:54:24 +0200
Subject: [patch 0/3] imx: Efika: Add pata device
Message-ID: <20110726145424.575429100@rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patchset is adding ressources, clock and device declarations for the
pata device available on imx51. Last patch enables pata on efika platforms.
To be complete, this patchset needs a driver, which is about to be sent for
merge to ata developers.

v2: Created a imx51_add_mxc_pata() as suggested
v3: Fix naming
v4: Change clock name to pata_imx

Arnaud
