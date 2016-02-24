From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Feb 2016 11:29:04 +0900
Subject: [PATCH 0/2] ARM: dts: use fallback jpu compatibility string
Message-ID: <1456280946-14859-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback jpu compatibility string in
device trees where it is not already used.

Based on renesas-devel-20160223-v4.5-rc5

Simon Horman (2):
  ARM: dts: r8a7790: use fallback jpu compatibility string
  ARM: dts: r8a7791: use fallback jpu compatibility string

 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.1.4
