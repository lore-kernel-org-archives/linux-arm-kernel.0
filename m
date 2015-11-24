From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Nov 2015 11:16:03 +0900
Subject: [PATCH v2 0/2] ARM: shmobile: alt: Correct pfc
Message-ID: <1448331365-21388-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

22b160713cb6 ("ARM: shmobile: alt: Add pfc pins to DT") introduced pfc pins
to the alt device tree but did not reference them. This patch set addresses
that and other deficiencies in that patch.

Written and tested against renesas-next-20151118-v4.4-rc1

Changes in v2:
* Corrected commit referenced in changelogs

Simon Horman (2):
  ARM: shmobile: alt: Correct scif2 pfc
  ARM: shmobile: alt: Correct ether pfc

 arch/arm/boot/dts/r8a7794-alt.dts | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.1.4
