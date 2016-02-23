From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 23 Feb 2016 10:17:44 +0900
Subject: [PATCH 0/2] ARM,
 arm64: dts: use fallback etheravb compatibility string
Message-ID: <1456190266-3781-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback etheravb compatibility string in
device trees where it is not already used.

Based on renesas-devel-20160222-v4.5-rc5

Simon Horman (2):
  ARM: dts: r8a7790: use fallback etheravb compatibility string
  arm64: dts: r8a7795: use fallback etheravb compatibility string

 arch/arm/boot/dts/r8a7790.dtsi           | 2 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.1.4
