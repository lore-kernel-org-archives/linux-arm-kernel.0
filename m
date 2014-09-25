From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 25 Sep 2014 10:32:10 +0900
Subject: [PATCH v3 0/4] ARM: shmobile: various DT files sorted by address
Message-ID: <1411608734-1349-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is an update of a series posted by Ulrich,
"ARM: shmobile: various DT files sorted by address",
the purpose of which is to sort DT nodes by their address.

Changes since v1.
* Drop patch reo remove spurious regulator base address as it
  gave two nodes the same name. Until better names be found just
  use the existing scheme (this series don't add the names it just
  moves the nodes).

Changes since v1.
* Some patches from the v1 series have been queued up and thus are not
  present in v2.
* Two new patches have been added to remove spurious regulator base
  addresses, as suggested by Geert Uytterhoeven. These correct incorrect
  lines before subsequent patches, rebased since v1, move them.

Based on renesas-next-20140918-v3.17-rc2
Targeted for inclusion in v3.19.

Simon Horman (1):
  ARM: shmobile: r8a73a4: Remove spurious dma-multiplexer base addresses

Ulrich Hecht (3):
  ARM: shmobile: r7s72100: sort dtsi file by address
  ARM: shmobile: kzm9d: sort dts file by address
  ARM: shmobile: r8a73a4: sort dtsi file by address

 arch/arm/boot/dts/emev2-kzm9d.dts |  62 +++++-----
 arch/arm/boot/dts/r7s72100.dtsi   | 202 ++++++++++++++++-----------------
 arch/arm/boot/dts/r8a73a4.dtsi    | 232 +++++++++++++++++++-------------------
 3 files changed, 248 insertions(+), 248 deletions(-)

-- 
2.0.1
