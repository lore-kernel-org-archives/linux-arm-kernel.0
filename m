From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 25 May 2011 22:16:25 +0800
Subject: Locking debug config in mxs_defconfig
Message-ID: <20110525141624.GE2408@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

When running image built from mxs_defconfig, we can see locking
warnings that Uwe reported before [1], because the debug locking
config options are turned on in defconfig.

You intended to mark this is something TODO?  Otherwise we can turn
them off until common clock sorts atomic/sleeping thing out?

[1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/100744

-- 
Regards,
Shawn
