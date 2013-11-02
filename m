From: silvio.maillist@gmail.com (Silvio F)
Date: Sat,  2 Nov 2013 08:29:03 +0100
Subject: [PATCH 0/3] add support for i.MX6 based cpu modul dmo edmqmx6
Message-ID: <cover.1383376255.git.silvio.fricke@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Silvio F (3):
  DT: sort vendor-prefixes.txt
  DT: Add Data Modul vendor prefix
  ARM: dts: imx6: Add support for imx6q dmo edmqmx6

 .../devicetree/bindings/vendor-prefixes.txt        |   5 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            | 163 +++++++++++++++++++++
 3 files changed, 167 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts

-- 
1.8.4
