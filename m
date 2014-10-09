From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Thu,  9 Oct 2014 19:03:01 +0900
Subject: [PATCH 0/4] ARM: shmobile: Add clock to DT
Message-ID: <1412848985-29353-1-git-send-email-ykaneko0929@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is based on the renesas-devel-20141007-v3.17 tag
of Simon's renesas tree.

Kouei Abe (2):
  ARM: shmobile: r8a7790: Add RGX clock to device tree
  ARM: shmobile: r8a7791: Add SGX clock to device tree

Yoshifumi Hosoya (2):
  ARM: shmobile: r8a7790: Add MMP clock to device tree
  ARM: shmobile: r8a7791: Add MMP clock to device tree

 arch/arm/boot/dts/r8a7790.dtsi            | 23 +++++++++++++++--------
 arch/arm/boot/dts/r8a7791.dtsi            | 22 ++++++++++++++--------
 include/dt-bindings/clock/r8a7790-clock.h | 12 +++++++++++-
 include/dt-bindings/clock/r8a7791-clock.h |  9 ++++++++-
 4 files changed, 48 insertions(+), 18 deletions(-)

-- 
1.9.1
