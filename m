From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Sun,  9 Aug 2015 20:26:40 -0700
Subject: [GIT PULL] ARM: Couple of Keystone MDIO DTS fixes for 4.2-rc6+
Message-ID: <1439177200-32434-1-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM-SoC folks,

Please pull below couple of late fixes for 4.2-rc6+. I know its late
with rc6 already out but if possible please consider. 

The following changes since commit f7644cbfcdf03528f0f450f3940c4985b2291f49:

  Linux 4.2-rc6 (2015-08-09 15:54:30 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts-late-fixes

for you to fetch changes up to 6a024079862443b3ec9455931e9219cd5912656d:

  ARM: dts: keystone: Fix the mdio bindings by moving it to soc specific file (2015-08-09 20:06:27 -0700)

----------------------------------------------------------------
ARM: Couple of Keysyone MDIO DTS fixes for 4.2-rc6+

These are necessary to get the NIC card working on all Keystone
EVMs. Couple of boards are nroken without these two fixes.

----------------------------------------------------------------
Murali Karicheri (2):
      ARM: dts: keystone: fix the clock node for mdio
      ARM: dts: keystone: Fix the mdio bindings by moving it to soc specific file

 arch/arm/boot/dts/k2e.dtsi      | 15 +++++++++++----
 arch/arm/boot/dts/k2hk.dtsi     | 11 +++++++++++
 arch/arm/boot/dts/k2l.dtsi      | 16 +++++++++++-----
 arch/arm/boot/dts/keystone.dtsi | 11 -----------
 4 files changed, 33 insertions(+), 20 deletions(-)


Regards,
Santosh
