From: patrice.chotard@st.com (Patrice Chotard)
Date: Tue, 15 Nov 2016 11:38:03 +0100
Subject: [GIT PULL] STi DT fix for v4.9-rcs
Message-ID: <3973615b-e1cb-25b3-fff0-201b56162f1a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin

Please consider this set for inclusion into the v4.9-rc.

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git tags/sti-dt-for-v4.9-rc

for you to fetch changes up to 5bf7b6e86f29f064979d7b3e6dd21c5dd1feb855:

  ARM: dts: STiH410-b2260: Fix typo in spi0 chipselect definition (2016-11-15 11:29:25 +0100)

----------------------------------------------------------------

STi DT fix:

Fix typo cs-gpio to cs-gpios

----------------------------------------------------------------
Loic Pallardy (1):
      ARM: dts: STiH410-b2260: Fix typo in spi0 chipselect definition

 arch/arm/boot/dts/stih410-b2260.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
