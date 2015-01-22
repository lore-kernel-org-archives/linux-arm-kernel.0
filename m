From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 22 Jan 2015 14:23:51 +0100
Subject: [GIT PULL] ARM: mediatek: DT changes for v3.20 (round 2)
Message-ID: <CABuKBeJ9+MnTFJ-s9cGnZ5e-m3t-qSSXm5pzY5c54Pr8JukQoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please take the following patch into account for v3.20.

Thanks a lot,
Matthias

---

The following changes since commit 3aa2e2811ab58e0299bb9a6457a15b405be86ff0:

  ARM: mediatek: dts: Add uart to Aquaris5 (2015-01-11 21:17:49 +0100)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v3.20-next-dts2

for you to fetch changes up to b8be56634b247e5dc892d8ec6d785e77a5f23845:

  ARM: mediatek: dts: Add uart to mt6592 (2015-01-20 18:09:39 +0100)

----------------------------------------------------------------
This adds uart support for mt6592 SoC.

----------------------------------------------------------------
Matthias Brugger (1):
      ARM: mediatek: dts: Add uart to mt6592

 arch/arm/boot/dts/mt6592.dtsi | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
