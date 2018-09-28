From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:18:59 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC Defconfig Updates for v4.20
Message-ID: <cover.1538124193.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC defconfig updates for v4.20.


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-defconfig-for-v4.20

for you to fetch changes up to 76506880eac66cb1f189a993c39ad0fcba723b99:

  arm64: defconfig: enable R8A774C0 SoC (2018-09-17 09:11:46 +0200)

----------------------------------------------------------------
Renesas ARM64 Based SoC Defconfig Updates for v4.20

* Enable recently upstreamed RZ/G2E (r8a774c0) and RZ/G2M (r8a774a1) SoCs

----------------------------------------------------------------
Biju Das (1):
      arm64: defconfig: enable R8A774A1 SoC

Fabrizio Castro (1):
      arm64: defconfig: enable R8A774C0 SoC

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
