From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Fri, 9 May 2014 10:04:31 +0800
Subject: [PATCHv4 0/2] add DT endianness binding support.
Message-ID: <1399601073-19278-1-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in V4:
- Fix one comment from Markus Pargmann.
- Fix some comments.

Changes in V3:
- Follow Mark Rutland's advice.
- Document common case of the endianess usage.

Changes in V2:
- Namespace the properties using the prefix sring.
- Add one binding ducomentation off regmap.




Xiubo Li (2):
  dt/bindings: Add the DT binding documentation for endianness
  regmap: add DT endianness binding support.

 .../devicetree/bindings/endianness/endianness.txt  |  48 +++++++
 drivers/base/regmap/regmap-i2c.c                   |   2 +
 drivers/base/regmap/regmap-spi.c                   |   2 +
 drivers/base/regmap/regmap.c                       | 147 +++++++++++++++++++--
 4 files changed, 188 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/endianness/endianness.txt

-- 
1.8.4
