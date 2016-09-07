From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Sep 2016 21:36:07 +0200
Subject: [GIT PULL] Allwinner fixes for 4.8
Message-ID: <20160907193607.GA5497@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following patch for the 4.8 release.

Thanks!
Maxime

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-fixes-for-4.8

for you to fetch changes up to 539d5c48a4aff5a4afcff117418618b49126c54c:

  ARM: sun5i: Fix typo in trip point temperature (2016-08-22 20:35:53 +0200)

----------------------------------------------------------------
Allwinner fixes for 4.8

A single patch fixing a typo in the temperature trip points in the A13
DTSI.

----------------------------------------------------------------
Hugo Grostabussiat (1):
      ARM: sun5i: Fix typo in trip point temperature

 arch/arm/boot/dts/sun5i-a13.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160907/46343d34/attachment-0001.sig>
