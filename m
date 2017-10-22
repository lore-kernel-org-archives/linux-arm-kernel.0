From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 23 Oct 2017 00:08:16 +0200
Subject: [GIT PULL] Mediatek: 64-bit DT update for v4.15
Message-ID: <9bf7b8c3-15b0-a73c-b27c-e21c8473e8ac@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the following commit.

Thanks,
Matthias

---
The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.14-next-dts64

for you to fetch changes up to f5a3d7837aa5fe619042694a3b0911243b8acc7f:

  arm64: dts: mediatek: Add cpuidle support for MT2712 (2017-10-10 19:04:08 +0200)

----------------------------------------------------------------
- mt2712: add cpuidle support

----------------------------------------------------------------
James Liao (1):
      arm64: dts: mediatek: Add cpuidle support for MT2712

 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
