From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 19 Aug 2017 16:09:13 +0800
Subject: [GIT PULL 4/4] Allwinner dts64 changes for 4.14, round 2
Message-ID: <20170819080913.mcaoh7u4uk3rfc2t@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here's the second batch of Allwinner arm64 device tree changes for 4.14.
This is based on the previous pull request that is already in arm-soc.

Thanks
ChenYu


The following changes since commit 78c3cbc80fec105d12a0f9aabe628090ae9c1749:

  arm64: allwinner: a64: add AXP803 PMIC support to SoPine and the baseboard (2017-07-24 09:56:00 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt64-for-4.14-2

for you to fetch changes up to 4969efb28b4301b09aba621f30cf81c582c018a8:

  arm64: allwinner: a64: Add A64-OLinuXino initial support (2017-08-15 12:07:11 +0800)

----------------------------------------------------------------
Allwinner arm64 device tree changes for 4.14, round 2

The usual improvement patches:

  - PMIC, USB and WiFi enabled for Bananapi M64

  - New board added: NanoPi A64

  - New board added: Olimex A64-OLinuXino

----------------------------------------------------------------
Icenowy Zheng (3):
      arm64: allwinner: a64: enable USB host controller for BPi M64
      arm64: allwinner: a64: enable AXP803 for Banana Pi M64
      arm64: allwinner: a64: add proper support for the Wi-Fi on BPi M64

Jagan Teki (2):
      arm64: allwinner: a64: Add initial NanoPi A64 support
      arm64: allwinner: a64: Add A64-OLinuXino initial support

 arch/arm64/boot/dts/allwinner/Makefile             |   2 +
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 144 +++++++++++++-
 .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   | 207 +++++++++++++++++++++
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    | 199 ++++++++++++++++++++
 4 files changed, 544 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170819/065f429b/attachment.sig>
