From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 2 May 2016 16:38:40 +0200
Subject: [GIT PULL] ARM: mediatek: dts64 updates for v4.7
Message-ID: <CABuKBe+2KnF_WFvhZ9ROz3mqJm1jv_+WteHvubfJQhNfS7vuUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Please feel free to pull the following patches.

Thanks a lot,
Matthias

---
The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.6-next-dts64

for you to fetch changes up to 962f5143b30568bf67be97365d0616b0050ddaa5:

  arm64: dts: mt8173: Add thermal zone node. (2016-04-21 15:55:11 +0200)

----------------------------------------------------------------
- add thermal and auxadc device nodes to mt8173
- add thermal zone nodes to mt8173

----------------------------------------------------------------
Sascha Hauer (1):
      ARM64: dts: mt8173: Add thermal/auxadc device nodes

dawei.chien at mediatek.com (1):
      arm64: dts: mt8173: Add thermal zone node.

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
