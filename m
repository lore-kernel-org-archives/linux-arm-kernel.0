From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 15:26:05 +0900
Subject: [GIT PULL] Renesas ARM-based SoC for v3.9 #2
Message-ID: <1359613569-26981-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit ff8de98d50e551057978ea90d09255c528fde1ac:

  ARM: shmobile: r8a7779: scif .irqs used SCIx_IRQ_MUXED() (2013-01-25 12:43:50 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.9

for you to fetch changes up to dc784e73b45dc055f9dcb174ea5753ea020516fc:

  ARM: mach-shmobile: sh73a0: allow unplugging of CPU0 (2013-01-30 13:07:59 +0900)

----------------------------------------------------------------
Second round of Renesas ARM-based SoC changes for v3.9

* Changes to allow unplugging of CPU0 by Ulrich Hecht.

* Changes to add reg and device_type properties to cpus
  device trees entries by Simon Horman.

----------------------------------------------------------------
Simon Horman (2):
      ARM: mach-shmobile: sh73a0:  Add reg and device_type properties to cpus
      ARM: mach-shmobile: emev2:  Add reg and device_type properties to cpus

Ulrich Hecht (2):
      ARM: mach-shmobile: add shmobile_cpu_disable_any()
      ARM: mach-shmobile: sh73a0: allow unplugging of CPU0

 arch/arm/boot/dts/emev2.dtsi                 |    7 +++++++
 arch/arm/boot/dts/sh73a0.dtsi                |    7 +++++++
 arch/arm/mach-shmobile/hotplug.c             |    6 ++++++
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/smp-sh73a0.c          |    2 +-
 5 files changed, 22 insertions(+), 1 deletion(-)
