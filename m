From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 18 Nov 2015 11:46:47 -0800
Subject: arm64 sched_clock cpu accounting
Message-ID: <564CD5A7.8000007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
  I noticed sched clock accounting can be enabled when arch-timer is
initialized. But arm64 doesn't appear to have 'HAVE_IRQ_TIME_ACCOUNTING'
selected (as of mainline 4.4-rc1) and IRQ_TIME_ACCOUNTING can't be selected.
After adding it to arch/arm64/Kconfig, option appears to work fine. Depending on
need all accounting options are fine, but irq time accounting appears to be most
preferable.

Any thoughts? Is it fine to enable it?

Thanks,
  Mario
