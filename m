From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 15:05:08 +0100
Subject: [GIT PULL] Renesas ARM Based SoC EtherAVB Updates for v4.10
Message-ID: <cover.1479390880.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC EtherAVB updates for v4.10.

This pull request is based on the "Second Round of Renesas ARM64 Based SoC
DT Updates for v4.10", tagged as arm64-dt-for-v4.10, which I have also sent
a pull-request for.

The reason for this base is to provide dependencies. For the same reason
an ack has been provided by David Miller to facilitate a merge of the patch
via the Renesas tree.


The following changes since commit 6f8a4c84d95031806594f5992a79fefd251c2f51:

  arm64: dts: r8a7796: Add device node for PRR (2016-11-17 14:48:28 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-ravb-for-v4.10

for you to fetch changes up to 735ea633e42060546cabe8430efbc00d4be1790a:

  ravb: Support 1Gbps on R-Car H3 ES1.1+ and R-Car M3-W (2016-11-17 14:53:44 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC EtherAVB Updates for v4.10

* Support 1Gbps on R-Car H3 ES1.1+ and R-Car M3-W

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ravb: Support 1Gbps on R-Car H3 ES1.1+ and R-Car M3-W

 drivers/net/ethernet/renesas/ravb_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)
