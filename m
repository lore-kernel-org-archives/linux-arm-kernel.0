From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 28 Mar 2011 17:12:21 -0000
Subject: [patch 00/29] arm: bug fixes and irq cleanup (v2) for .39
Message-ID: <20110328170219.059141076@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series contains a few bugfixes, which I made in order to
compile the irq cleanup series.

The irq cleanup series is almost the same except for a few typo fixups and
does not longer remove the tegra resume/suspend stuff, but removes the irq
fiddling inside.

For your conveniance the series is also available from:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git irq/for-arm

once the mirror decided to sync.

Please let me know how to proceed with this lot.

Thanks,

	tglx
