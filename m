From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 20 Nov 2014 23:48:56 +0100
Subject: [GIT PULL 2/2] ARM: berlin: DT changes for v3.19 (round 2)
In-Reply-To: <1416523736-13504-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1416523736-13504-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1416523736-13504-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this is incremental Berlin DT changes for v3.19 round 2. Finally,
after almost two cycles, Antoine succeeded in getting Acked-bys
for his chipidea usb to generic PHY patches, which also allows us
to reuse that very driver on all Berlin SoCs.

Again this PR is between tags/berlin-dt-3.19-1 and tags/berlin-dt-3.19-2.

Please pull.

Thanks,
  Sebastian

The following changes since commit e4fdc8e5821d852a933963ba56b9b2fa8f68c68f:

  ARM: dts: berlin: Enable eMMC on Sony NSZ-GS7 (2014-10-29 19:44:47 +0100)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-dt-3.19-2

for you to fetch changes up to ea7aaa26273431650cb94e712c7c7cfec4306587:

  ARM: dts: berlin: enable USB on the Google Chromecast (2014-11-18 20:34:30 +0100)

----------------------------------------------------------------
Berlin DT changes for v3.19 (round 2)
- AHCI and SATA PHY nodes for BG2
- USB and USB PHZ nodes for BG2/BG2CD/BG2Q

----------------------------------------------------------------
Antoine Tenart (2):
      ARM: dts: berlin: add BG2Q nodes for USB support
      ARM: dts: Berlin: enable USB on the BG2Q DMP

Sebastian Hesselbarth (4):
      ARM: berlin: Add AHCI and SATA PHY nodes to BG2
      ARM: berlin: Enable SATA on Sony NSZ-GS7
      ARM: dts: berlin: add BG2CD nodes for USB support
      ARM: dts: berlin: enable USB on the Google Chromecast

 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts        |  7 +++
 arch/arm/boot/dts/berlin2.dtsi                    | 39 ++++++++++++++++
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts |  4 ++
 arch/arm/boot/dts/berlin2cd.dtsi                  | 36 +++++++++++++++
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts        | 53 ++++++++++++++++++++++
 arch/arm/boot/dts/berlin2q.dtsi                   | 54 +++++++++++++++++++++++
 6 files changed, 193 insertions(+)
