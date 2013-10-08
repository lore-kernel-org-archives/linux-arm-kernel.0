From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 08 Oct 2013 12:38:51 +0900
Subject: [PATCH 00/08] ARM: shmobile: r8a7791 and Koelsch GPIO/PFC support
Message-ID: <20131008033851.20455.68845.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: r8a7791 and Koelsch GPIO/PFC support

[PATCH 01/08] ARM: shmobile: r8a7791 PFC device tree node
[PATCH 02/08] ARM: shmobile: r8a7791 PFC platform device support
[PATCH 03/08] ARM: shmobile: Select GPIO in case of the r8a7791 SoC
[PATCH 04/08] ARM: shmobile: r8a7791 GPIO device tree node
[PATCH 05/08] ARM: shmobile: r8a7791 GPIO platform device support
[PATCH 06/08] ARM: shmobile: Enable PFC/GPIO on the Koelsch board
[PATCH 07/08] ARM: shmobile: Add Koelsch LED6, LED7 and LED8 support
[PATCH 08/08] ARM: shmobile: Add Koelsch SW2 support

This series includes PFC and GPIO support for the r8a7791 SoC and the
Koelsch board. The GPIO portion can be tested through LEDs and GPIO
switches on the Koelsch board. PFC tables will be submitted separately.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-20131004

 arch/arm/boot/dts/r8a7791.dtsi                |  102 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                |    1 
 arch/arm/mach-shmobile/board-koelsch.c        |   50 ++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a7791.h |    1 
 arch/arm/mach-shmobile/setup-r8a7791.c        |   53 ++++++++++++
 5 files changed, 207 insertions(+)
