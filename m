From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 6 Jan 2017 14:39:57 +0100
Subject: [GIT PULL] ARM: OXNAS SoC DT updates for 4.11
Message-ID: <fc1ba783-7bb6-2aa2-3e63-fdf318984eb8@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  https://github.com/OXNAS/linux.git tags/oxnas-arm-soc-dt-for-4.11

for you to fetch changes up to 0c5987d3e3c5bf7fb861230ee6d2a0f17a1dcd3b:

  ARM: dts: OX820: Update with dt-bindings includes (2017-01-04 10:31:34 +0100)

----------------------------------------------------------------
- Add dt-bindings includes for OX820 and OX810SE dtsi
- Replace reset and clock magic numbers for OX820 and OX810SE

----------------------------------------------------------------
Neil Armstrong (2):
      ARM: dts: OX810: Update with dt-bindings includes
      ARM: dts: OX820: Update with dt-bindings includes

 arch/arm/boot/dts/ox810se.dtsi | 10 ++++++----
 arch/arm/boot/dts/ox820.dtsi   | 14 ++++++++------
 2 files changed, 14 insertions(+), 10 deletions(-)

Thanks,
Neil
