From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Apr 2016 14:20:34 +1000
Subject: [GIT PULL] Renesas ARM Based SoC DT PM Domain Updates for v4.7
Message-ID: <cover.1461730638.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT pm-domain updates for v4.7.

This pull requests is based on a merge of:

* "[GIT PULL] Second Round of Renesas ARM Based SoC R-Car SYSC Updates for
  v4.7", tagged as renesas-rcar-sysc2-for-v4.7, which you have already
  pulled.
* "[GIT PULL v2] Renesas ARM Based SoC DT Updates for v4.7",
  tagged as renesas-dt-for-v4.7, which you have also already pulled.

The reason for the somewhat tedious base on
renesas-rcar-sysc2-for-v4.7, which provides driver changes,
is a hard run-time dependency.

I also have a similar set of changes for arm64 which I will send separately.


The following changes since commit 03ef285fd75f0a47461048832367ea71ec1bc65b:

  Merge tag 'renesas-rcar-sysc2-for-v4.7' into dt-pm-domain-for-v4.7 (2016-04-27 11:35:26 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-pm-domain-for-v4.7

for you to fetch changes up to 25611e4ef5bb290805305d499715a840826462f3:

  ARM: dts: r8a7794: Use SYSC "always-on" PM Domain (2016-04-27 14:16:18 +1000)

----------------------------------------------------------------
Renesas ARM Based SoC DT PM Domain Updates for v4.7

* Add SYSC PM Domains to DT for R-Car Gen 1 and 2 SoCs

----------------------------------------------------------------
Geert Uytterhoeven (10):
      ARM: dts: r8a7779: Add SYSC PM Domains
      ARM: dts: r8a7790: Add SYSC PM Domains
      ARM: dts: r8a7791: Add SYSC PM Domains
      ARM: dts: r8a7793: Add SYSC PM Domains
      ARM: dts: r8a7794: Add SYSC PM Domains
      ARM: dts: r8a7779: Use SYSC "always-on" PM Domain
      ARM: dts: r8a7790: Use SYSC "always-on" PM Domain
      ARM: dts: r8a7791: Use SYSC "always-on" PM Domain
      ARM: dts: r8a7793: Use SYSC "always-on" PM Domain
      ARM: dts: r8a7794: Use SYSC "always-on" PM Domain

 arch/arm/boot/dts/r8a7779.dtsi |  54 ++++++++------
 arch/arm/boot/dts/r8a7790.dtsi | 155 ++++++++++++++++++++++------------------
 arch/arm/boot/dts/r8a7791.dtsi | 156 ++++++++++++++++++++++-------------------
 arch/arm/boot/dts/r8a7793.dtsi | 111 +++++++++++++++--------------
 arch/arm/boot/dts/r8a7794.dtsi | 116 ++++++++++++++++--------------
 5 files changed, 324 insertions(+), 268 deletions(-)
