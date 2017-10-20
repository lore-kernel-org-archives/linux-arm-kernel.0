From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Oct 2017 09:59:00 +0200
Subject: [GIT PULL] Allwinner fixes for 4.14
Message-ID: <20171020075900.25c4w3ti7ryx4ztp@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are two fixes for the current release.

Thanks!
Maxime

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-fixes-for-4.14

for you to fetch changes up to a231d2783c332ef3e3ba238e82dbe599ff41ba14:

  ARM: dts: sun6i: Fix endpoint IDs in second display pipeline (2017-09-17 12:03:59 +0200)

----------------------------------------------------------------
Allwinner fixes for 4.14

Two fixes, one for the A31 DRM binding, and one for a missing regulator on
the pine MMC controller.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: dts: sun6i: Fix endpoint IDs in second display pipeline

Jagan Teki (1):
      arm64: allwinner: a64: pine64: Use dcdc1 regulator for mmc0

 arch/arm/boot/dts/sun6i-a31.dtsi                    | 16 ++++++++--------
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  9 +--------
 2 files changed, 9 insertions(+), 16 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171020/103e048c/attachment-0001.sig>
