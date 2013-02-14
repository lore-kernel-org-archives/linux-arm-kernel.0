From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 14 Feb 2013 20:53:52 -0000
Subject: [patch 0/2] ARM: Allow forced irq threading
Message-ID: <20130214205204.109023136@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forced irq threading is a prerequisite for RT and a nice debug feature
(enabled via commandline option) in mainline.

The following series adds the tiny missing pieces to enable this on
the arm architecture.

Thanks,

	tglx
