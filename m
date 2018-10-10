From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 10 Oct 2018 20:07:52 +0900
Subject: [Question] directory for SoC-related DT binding
Message-ID: <CAK7LNATaD=G8BW316fkBWM2A+YXgP5tabaySR2Fs49Za_0p=3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


I see a bunch of vendor (or SoC) names in
Documentation/device/bindings/arm/

./Documentation/devicetree/bindings/arm/altera
./Documentation/devicetree/bindings/arm/amlogic
./Documentation/devicetree/bindings/arm/apm
./Documentation/devicetree/bindings/arm/bcm
./Documentation/devicetree/bindings/arm/calxeda
./Documentation/devicetree/bindings/arm/freescale
./Documentation/devicetree/bindings/arm/hisilicon
./Documentation/devicetree/bindings/arm/keystone
./Documentation/devicetree/bindings/arm/marvell
./Documentation/devicetree/bindings/arm/mediatek
./Documentation/devicetree/bindings/arm/mrvl
./Documentation/devicetree/bindings/arm/msm
./Documentation/devicetree/bindings/arm/npcm
./Documentation/devicetree/bindings/arm/nxp
./Documentation/devicetree/bindings/arm/omap
./Documentation/devicetree/bindings/arm/rockchip
./Documentation/devicetree/bindings/arm/samsung
./Documentation/devicetree/bindings/arm/stm32
./Documentation/devicetree/bindings/arm/sunxi
./Documentation/devicetree/bindings/arm/tegra
./Documentation/devicetree/bindings/arm/ti
./Documentation/devicetree/bindings/arm/uniphier
./Documentation/devicetree/bindings/arm/ux500
./Documentation/devicetree/bindings/arm/vt8500


I also see some vendor names in
Documentation/device/bindings/soc/

./Documentation/devicetree/bindings/soc/bcm
./Documentation/devicetree/bindings/soc/dove
./Documentation/devicetree/bindings/soc/fsl
./Documentation/devicetree/bindings/soc/mediatek
./Documentation/devicetree/bindings/soc/qcom
./Documentation/devicetree/bindings/soc/rockchip
./Documentation/devicetree/bindings/soc/ti
./Documentation/devicetree/bindings/soc/xilinx
./Documentation/devicetree/bindings/soc/zte



Confusingly, I see bcm, mediatek, rockchip
in both locations.

Is there any rule to choose one than the other?




-- 
Best Regards
Masahiro Yamada
