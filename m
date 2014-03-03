From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Mar 2014 11:20:52 +0100
Subject: [GIT PULL] Allwinner fixes for 3.14
Message-ID: <20140303102052.GA28112@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-fixes-for-3.14

for you to fetch changes up to 40dd8f3b900cac1d925605a9d3199368c4af0a40:

  ARM: sunxi: dt: Change the touchscreen compatibles (2014-02-07 22:30:05 +0100)

----------------------------------------------------------------
Two fixes for device trees additions that got added in 3.14. One fixes the
interrupt types of some IPs, the other fixes up a compatible that got
introduced during 3.14

----------------------------------------------------------------
Maxime Ripard (2):
      ARM: sun7i: dt: Fix interrupt trigger types
      ARM: sunxi: dt: Change the touchscreen compatibles

 arch/arm/boot/dts/sun4i-a10.dtsi  |  2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi |  2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi  |  2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi  | 12 ++++++------
 4 files changed, 9 insertions(+), 9 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/8fbdd9b4/attachment.sig>
