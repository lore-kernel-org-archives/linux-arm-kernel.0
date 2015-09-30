From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 30 Sep 2015 13:53:35 +0100
Subject: [PATCH 0/8] nvmem: new drivers for v4.4
Message-ID: <1443617615-26261-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Here are 4 new nvmem drivers which are in the mailing list for long time
and are good to go for some testing and find its way to v4.4-rc*.

Could you please take these patches via char-misc tree.

Thanks,
srini


Philipp Zabel (2):
  nvmem: Add i.MX6 OCOTP device tree binding documentation
  nvmem: imx-ocotp: Add i.MX6 OCOTP driver

Sanchayan Maity (2):
  nvmem: Add DT binding documentation for Vybrid OCOTP driver
  nvmem: Add Vybrid OCOTP support

Stefan Wahren (2):
  nvmem: add binding for mxs-ocotp
  nvmem: add driver for ocotp in i.MX23 and i.MX28

ZhengShunQian (2):
  nvmem: rockchip-efuse: describe the usage of eFuse
  nvmem: Adding bindings for rockchip-efuse

 .../devicetree/bindings/nvmem/imx-ocotp.txt        |  20 ++
 .../devicetree/bindings/nvmem/mxs-ocotp.txt        |  25 ++
 .../devicetree/bindings/nvmem/rockchip-efuse.txt   |  38 +++
 .../devicetree/bindings/nvmem/vf610-ocotp.txt      |  19 ++
 drivers/nvmem/Kconfig                              |  42 +++
 drivers/nvmem/Makefile                             |   8 +
 drivers/nvmem/imx-ocotp.c                          | 154 +++++++++++
 drivers/nvmem/mxs-ocotp.c                          | 257 ++++++++++++++++++
 drivers/nvmem/rockchip-efuse.c                     | 186 +++++++++++++
 drivers/nvmem/vf610-ocotp.c                        | 302 +++++++++++++++++++++
 10 files changed, 1051 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/mxs-ocotp.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
 create mode 100644 drivers/nvmem/imx-ocotp.c
 create mode 100644 drivers/nvmem/mxs-ocotp.c
 create mode 100644 drivers/nvmem/rockchip-efuse.c
 create mode 100644 drivers/nvmem/vf610-ocotp.c

-- 
1.9.1
