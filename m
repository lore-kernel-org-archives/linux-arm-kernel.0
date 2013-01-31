From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 10:50:47 +0900
Subject: ARM: mach-shmobile: r8a7779, marzen: Reference DT implementation
Message-ID: <1359597051-32700-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide minimal DT initialisation for the r8a7779 SoC and
marzen board as a reference for developers.

In general the idea is to grow the hardware supported by this
initialisation as DT coverage of relevant drivers and other code
grows.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

overall diffstat:
 arch/arm/boot/dts/Makefile                      |    1 
 arch/arm/boot/dts/r8a7779-marzen-reference.dts  |   41 ++++++
 arch/arm/boot/dts/r8a7779.dtsi                  |   85 ++++++++++++++
 arch/arm/configs/marzen_defconfig               |    2 
 arch/arm/mach-shmobile/Kconfig                  |   11 +
 arch/arm/mach-shmobile/Makefile                 |    1 
 arch/arm/mach-shmobile/board-marzen-reference.c |   71 +++++++++++
 arch/arm/mach-shmobile/include/mach/common.h    |    3 
 arch/arm/mach-shmobile/intc-r8a7779.c           |   27 +++-
 arch/arm/mach-shmobile/setup-r8a7779.c          |   58 ++++++++-
 10 files changed, 288 insertions(+), 12 deletions(-)
