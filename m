From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 27 Jun 2018 21:24:20 -0700
Subject: [PATCH 0/4] RDU1/2 latest supported RAVE SP nodes
Message-ID: <20180628042424.12664-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn:

These are patches adding the rest of RAVE SP child nodes covering all
the rest of currently supported MFD cells. There's more to be added,
once more drivers get accepted upstream.

The bindings three drivers mentioned are availible in:

    Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
    Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
    Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt

Feedback is welcome!

Thanks,
Andrey Smirnov

Andrey Smirnov (4):
  ARM: dts: imx51-zii-rdu1: Populate RAVE SP EEPROM nodes
  ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP EEPROM nodes
  ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP backlight node
  ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP power button node

 arch/arm/boot/dts/imx51-zii-rdu1.dts    | 29 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 26 ++++++++++++++++++++++
 2 files changed, 55 insertions(+)

-- 
2.17.1
