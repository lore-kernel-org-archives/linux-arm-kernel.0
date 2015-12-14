From: songjun.wu@atmel.com (Songjun Wu)
Date: Mon, 14 Dec 2015 16:15:38 +0800
Subject: [PATCH 0/2] ASoC: atmel-pdmic: add driver for Atmel PDMIC
Message-ID: <1450080940-4123-1-git-send-email-songjun.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Pulse Density Modulation Inteface Controller driver
includes two parts.
1) Driver code to implement the PDMIC function.
2) Device tree binding documentation, it describes how to add
   the PDMIC in device tree.


Songjun Wu (2):
  ASoC: atmel-pdmic: add the Pulse Density Modulation Interface
    Controller
  ASoC: atmel-pdmic: DT binding for PDMIC driver

 .../devicetree/bindings/sound/atmel-pdmic.txt      |   55 ++
 sound/soc/atmel/Kconfig                            |    9 +
 sound/soc/atmel/Makefile                           |    2 +
 sound/soc/atmel/atmel-pdmic.c                      |  745 ++++++++++++++++++++
 sound/soc/atmel/atmel-pdmic.h                      |   80 +++
 5 files changed, 891 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-pdmic.txt
 create mode 100644 sound/soc/atmel/atmel-pdmic.c
 create mode 100644 sound/soc/atmel/atmel-pdmic.h

-- 
1.7.9.5
