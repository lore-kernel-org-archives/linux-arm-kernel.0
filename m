From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 12 Dec 2016 09:30:00 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.10
Message-ID: <cover.1481530910.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC fixes for v4.10.

This provides an sd0_uhs node rather than duplicate sdh0 nodes
resolving an error introduced in a clean-up patch.

This pull request is based on "Second Round of Renesas ARM Based SoC DT
Updates for v4.10", tagged as renesas-arm64-dt2-for-v4.10,
which you have already pulled. The error corrected by this change
was introduced in that pull-request.


The following changes since commit 5de68961cf5618c1ce5bb15848b36121247f23d5:

  arm64: dts: r8a7796: Add device node for PRR (2016-11-21 10:18:53 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v4.10

for you to fetch changes up to 8ebcb400af619ee0ddeb39c06fc35511b20cc697:

  arm64: dts: h3ulcb: Provide sd0_uhs node (2016-12-08 14:29:17 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes for v4.10

* Provide sd0_uhs node

----------------------------------------------------------------
Simon Horman (1):
      arm64: dts: h3ulcb: Provide sd0_uhs node

 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
