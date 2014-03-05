From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  5 Mar 2014 22:21:12 +0100
Subject: [RESEND Patch 0/2] DT vendor/soc updates
Message-ID: <1394054474-4310-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a resend because i've been told they did not make it to the
list properly.

Andrew Lunn (2):
  DT: Vendor: Add prefixes used by Kirkwood devices
  DT: bindings: add missing Marvell Kirkwood SoC documentation

 .../devicetree/bindings/arm/marvell,kirkwood.txt   | 97 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        | 13 +++
 2 files changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell,kirkwood.txt

-- 
1.9.0
