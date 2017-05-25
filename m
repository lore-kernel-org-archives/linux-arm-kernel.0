From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 26 May 2017 01:44:42 +0200
Subject: [PATCH 0/2] Document and use eeprom-length property
Message-ID: <1495755884-31341-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mv88e6xxx switch driver allows the size of the attached EEPROM to
be described in DT. This property is missing from the binding
documentation. Add it. And make use of it on the ZII Devel B board.

David, Shawn, please could you talk amongs yourself to decide who
takes what.

Andrew Lunn (2):
  net: dsa: mv88e6xxx: Add eeprom-length to binding
  ARM: VF610: ZII devel b: Add switch eeprom-length properties

 Documentation/devicetree/bindings/net/dsa/marvell.txt | 4 ++++
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts             | 2 ++
 2 files changed, 6 insertions(+)

-- 
2.11.0
