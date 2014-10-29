From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 13:59:53 +0900
Subject: [GIT PULL] Renesas ARM Based SoC r8a73a4 DT Timers Updates for v3.19
Message-ID: <cover.1414557047.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC r8a73a4 DT timers updates for v3.19.

This pull-request is based on "[GIT PULL] Renesas ARM Based SoC DT Cleanups
for v3.19", tagged as dt-cleanups-for-v3.19, which I have also sent a
pull-request for.

The reason for this base is to avoid conflicts.


This pull-request is in a stand-alone branch as it includes
an board, SoC and DT changes that depend on each other in
an order other than the way branches dependencies are usually arranged.


The following changes since commit 120f038cf04b95dc895cba503a7516ff75561438:

  ARM: shmobile: kzm9d dts: Add chosen/stdout-path (2014-10-24 10:44:10 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-r8a73a4-dt-timers-for-v3.19

for you to fetch changes up to fd3edcbe9f7bf24b13cadca7616f8e10bbe7e2b3:

  ARM: shmobile: r8a73a4: Remove empty r8a73a4_add_dt_devices (2014-10-24 11:54:49 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC r8a73a4 DT Timers Updates for v3.19

* Initialise CMT1 timer using DT

----------------------------------------------------------------
Simon Horman (4):
      ARM: shmobile: r8a73a4: Add CMT1 node
      ARM: shmobile: r8a73a4: Rename cmt registration helper
      ARM: shmobile: ape6evm-reference: Initialise CMT1 device using DT
      ARM: shmobile: r8a73a4: Remove empty r8a73a4_add_dt_devices

 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  |  4 ++++
 arch/arm/boot/dts/r8a73a4.dtsi                   | 11 +++++++++++
 arch/arm/mach-shmobile/board-ape6evm-reference.c |  1 -
 arch/arm/mach-shmobile/r8a73a4.h                 |  1 -
 arch/arm/mach-shmobile/setup-r8a73a4.c           |  9 ++-------
 5 files changed, 17 insertions(+), 9 deletions(-)
