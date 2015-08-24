From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 24 Aug 2015 10:26:04 +0200
Subject: [PATCH v2 0/2] i.MX6 OCOTP NVMEM support
In-Reply-To: <1438940901-5779-1-git-send-email-p.zabel@pengutronix.de>
References: <1438940901-5779-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1440404764.4444.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Am Freitag, den 07.08.2015, 11:48 +0200 schrieb Philipp Zabel:
> Hi,
> 
> These patches add support for the i.MX On-Chip OTP (eFuse) Controller found
> in i.MX6Q/D, i.MX6S/DL, i.MX6SL, and i.MX6SX SoCs to the NVMEM framework.
> Greg, could you take them into the char-misc tree together with the NVMEM
> framework?

is anything blocking this?

best regards
Philipp

> Changes since v1:
>  - Dropped unneeded clk.h include
>  - Fixed MODULE_LICENSE
>  - Droped third patch (adding the clock to the device tree node can be done separately)
> 
> Philipp Zabel (2):
>   nvmem: Add i.MX6 OCOTP device tree binding documentation
>   nvmem: imx-ocotp: Add i.MX6 OCOTP driver
> 
>  .../devicetree/bindings/nvmem/imx-ocotp.txt        |  20 +++
>  drivers/nvmem/Kconfig                              |  11 ++
>  drivers/nvmem/Makefile                             |   2 +
>  drivers/nvmem/imx-ocotp.c                          | 154 +++++++++++++++++++++
>  4 files changed, 187 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
>  create mode 100644 drivers/nvmem/imx-ocotp.c
