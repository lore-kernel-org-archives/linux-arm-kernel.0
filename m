From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 08 Oct 2013 15:30:00 +0900
Subject: [PATCH 00/02] ARM: shmobile: r8a7791 Koelsch DT reference support V2
Message-ID: <20131008063000.24789.7845.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: r8a7791 Koelsch DT reference support V2

[PATCH 01/02] ARM: shmobile: r8a7791 Koelsch DT reference DTS bits
[PATCH 02/02] ARM: shmobile: r8a7791 Koelsch DT reference C bits

This series is V2 of Koelsch DT reference support. At this point the
board file is separated from the legacy Koelsch board support, and in
the not so distant future this DT reference board file will be converted
into MULTIPLATFORM only. This can only happen after r8a7791 CCF support
has been added.

After CCF and MULTIPLATFORM are done for r8a7791 the board support code
will be converted into same style as EMEV2, for more details please
see the following series:

[PATCH 00/05] ARM: shmobile: KZM9D Multiplatform update

Changes since V1 are DT_MACHINE update to sync with legacy board
code and patch splitting to simplify merge dependencies.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-20131008

 arch/arm/boot/dts/Makefile                       |    1 
 arch/arm/boot/dts/r8a7791-koelsch-reference.dts  |   32 +++++++++++++++
 arch/arm/mach-shmobile/Kconfig                   |   11 +++++
 arch/arm/mach-shmobile/Makefile                  |    1 
 arch/arm/mach-shmobile/Makefile.boot             |    1 
 arch/arm/mach-shmobile/board-koelsch-reference.c |   46 ++++++++++++++++++++++
 6 files changed, 92 insertions(+)
