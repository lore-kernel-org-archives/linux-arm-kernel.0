From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 17 Jul 2014 11:18:22 +0200
Subject: ARM: mvebu: ARCH_HAS_CPUFREQ
Message-ID: <1405588702.4808.6.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas, Jason,

0) Linux-next includes your commit a02829b0485e ("ARM: mvebu: allow
enabling of cpufreq on Armada XP") as of today (next-20140717).

1) That commit only adds
    select ARCH_HAS_CPUFREQ

to a Kconfig entry. But ARCH_HAS_CPUFREQ was dropped in v3.16-rc2, see
commit 19682f72f5db ("ARM: Remove ARCH_HAS_CPUFREQ config option").
While I don't know what you want to achieve here, selecting
ARCH_HAS_CPUFREQ certainly won't help you.


Paul Bolle
