From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 20 Jun 2013 22:09:09 +0900
Subject: [GIT PULL 0/2] Renesas ARM based SoC GPIO R-Car updates for v3.11 #2
Message-ID: <1371733751-27730-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

this pull request is based on renesas-gpio-rcar-for-v3.11,
which you have already pulled. That tag adds the code and
documentation which is updated by the patches in this pull-request.

The following changes since commit 159f8a0209aff155af7f6fcdedd4a4484dd19c23:

  gpio-rcar: Add DT support (2013-06-12 21:48:09 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-gpio-rcar2-for-v3.11

for you to fetch changes up to e305062e94719ef543ae936dd56501b5a36406c6:

  gpio-rcar: Remove #ifdef CONFIG_OF around OF-specific sections (2013-06-19 21:38:38 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM based SoC GPIO R-Car updates for v3.11

Documentation enhancement and code cleanup by Laurent Pinchart.

----------------------------------------------------------------
Laurent Pinchart (2):
      gpio-rcar: Reference core gpio documentation in the DT bindings
      gpio-rcar: Remove #ifdef CONFIG_OF around OF-specific sections

 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt     | 18 ++++++------------
 drivers/gpio/gpio-rcar.c                               |  8 ++------
 2 files changed, 8 insertions(+), 18 deletions(-)
