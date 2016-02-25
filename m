From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 08:52:55 +0900
Subject: [GIT PULL] Renesas ARM64 Based SoC SoC Updates for v4.6
Message-ID: <cover.1456442718.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC SoC updates for v4.6.


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-soc-for-v4.6

for you to fetch changes up to 2ee98234b88174f2bcafefb7918e2794a1fdbc98:

  arm64: renesas: Enable PM and PM_GENERIC_DOMAINS for SoCs with PM Domains (2016-02-19 14:55:18 +0900)

----------------------------------------------------------------
Renesas ARM64 Based SoC SoC Updates for v4.6

* Enable RENESAS_IRQC, and PM and PM_GENERIC_DOMAINS for SoCs with PM Domains

----------------------------------------------------------------
Geert Uytterhoeven (1):
      arm64: renesas: Enable PM and PM_GENERIC_DOMAINS for SoCs with PM Domains

Magnus Damm (1):
      arm64: renesas: Enable RENESAS_IRQC

 arch/arm64/Kconfig.platforms | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
