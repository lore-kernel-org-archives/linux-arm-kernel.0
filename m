From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 18 Oct 2015 14:23:40 +0200
Subject: [resend GIT PULL] ARM: mediatek: arm64 updates for v4.3
Message-ID: <CABuKBeJbELoYh7fC_QNGgPxVHHhjioVn++z6Qj0W2X5Q-imL0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the following patches.

I resend this pull request, because I forgot to add the arm mailing
list in the first place.

Thanks,
Matthias

---

The following changes since commit 1f93e4a96c9109378204c147b3eec0d0e8100fde:

  Linux 4.3-rc2 (2015-09-20 14:32:34 -0700)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.3-next-arm64

for you to fetch changes up to e34573c95a1416b4f26a5cc68b1de198e6b27ad7:

  arm64: dts: mt8173: Add clocks for SCPSYS unit (2015-10-14 15:43:13 +0200)

----------------------------------------------------------------
Correct i2c DTS node names in mt8173.dtsi.

Add spi DTS node to the mt8173 and mt8173-evb.

Add dts nodes for the subsystem clocks on mt8173.
This includes mmsys, imgsys, vdecsys, vencsys, vencltsys.

Add clock nodes to the scpsys binding, which are needed to
access the registers of venc and venc_lt power domains.

----------------------------------------------------------------
James Liao (2):
      arm64: dts: mt8173: Add subsystem clock controller device nodes
      arm64: dts: mt8173: Add clocks for SCPSYS unit

Leilk Liu (1):
      arm64: dts: Add spi bus dts

Yingjoe Chen (1):
      arm64: mt8173.dtsi: correct i2c node names

 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 18 +++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 62 ++++++++++++++++++++++++++---
 2 files changed, 75 insertions(+), 5 deletions(-)
