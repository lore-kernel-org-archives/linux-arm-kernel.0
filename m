From: james@innovum.com.au (James Pettigrew)
Date: Tue,  6 Sep 2016 08:15:55 +1000
Subject: [PATCH v4 0/2] ARM: sunxi: Add support for FriendlyARM NanoPi NEO SBC
In-Reply-To: <1472701734-1837-1-git-send-email-james@innovum.com.au>
References: <1472701734-1837-1-git-send-email-james@innovum.com.au>
Message-ID: <cover.1473112593.git.james@innovum.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2:
	As per Rask's review (thank you):
		Added vendor prefix
		Removed unncessary input.h include
		Fixed underscores and unnecessary unit addresses in node names
		Added GPIO pin comments to led nodes

Changes in v3:
	Fixed syntax errors

Changes in v4:
	Moved change to vendor-prefixes into separate patch

James Pettigrew (2):
  ARM: dts: sun8i: Add dts file for the NanoPi NEO SBC
  devicetree: Add vendor prefix for FriendlyARM

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts          | 125 +++++++++++++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts

-- 
1.9.1
