From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed,  8 Jun 2016 14:33:06 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.8
Message-ID: <1465414387-20171-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in these updates for v4.8.

Thanks,
Dinh


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_updates_v4.8

for you to fetch changes up to b65c0efa3508c01116c3ee24a6c37a158f2cb03a:

  ARM: dts: socfpga: fix definitions of serial console (2016-06-08 14:09:11 -0500)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.8
- Update Arria10 ECC manager
- Add ethernet alias for Arria10
- Update serial alias for Arria10

----------------------------------------------------------------
Dinh Nguyen (1):
      ARM: dts: socfpga: add ethernet alias on Arria10

Matthew Gerlach (1):
      ARM: dts: socfpga: fix definitions of serial console

Thor Thayer (2):
      ARM: dts: Arria10 ECC Manager IRQ controller changes
      ARM: dts: Move Arria10 SDRAM as child of ECC Manager

 arch/arm/boot/dts/socfpga_arria10.dtsi       | 24 +++++++++++++-----------
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi |  7 ++++++-
 2 files changed, 19 insertions(+), 12 deletions(-)
