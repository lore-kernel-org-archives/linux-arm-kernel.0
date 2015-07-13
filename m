From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Jul 2015 20:28:58 -0000
Subject: [patch 00/11] ARM: Interrupt cleanups and API change preparation
Message-ID: <20150713090726.316699641@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch series contains the following changes:

    - Consolidation of chained interrupt handler setup/removal

    - Switch to functions which avoid a redundant interrupt
      descriptor lookup

    - Preparation of interrupt flow handlers for the 'irq' argument
      removal

The series has no dependencies and is also available as a git branch
for your convenience:

 git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/arm

If you want me to carry the patches in the irq/core branch of tip,
please let me know.

Thanks,

	tglx
