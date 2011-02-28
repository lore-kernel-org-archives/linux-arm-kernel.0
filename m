From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 28 Feb 2011 14:21:32 +0100
Subject: [patch 0/2] Get watchdog reboot working on efika smartbook
Message-ID: <20110228132132.654689676@rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

With current patches in Sascha Hauer's tree, the efika smartbook is powering
off when rebooting. The cause of this bug is the default behaviour of the
mc13892 pmic. This patchset is configuring the pmic to reboot the system 
as expected by imx system.c (the reboot is done throught watchdog) and enables
the watchdog on the efika mx/sb systems.

Arnaud
