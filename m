From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 2 Feb 2012 10:11:59 +0800
Subject: [PATCH v2 0/9] imx patches when I enable imx6q sabrelite audio
Message-ID: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2:

 - change dt peroperty/label to lower case as much as possible
   keep XXX-supply property upper case.
 - convert audmux-v2 to platform device driver
 - move audmux-v2 driver to sound/soc/imx

[PATCH v2 1/9] ARM: mxc: make imx_dma_is_general_purpose more
[PATCH v2 2/9] ARM: imx6q: add cko1 clock
[PATCH v2 3/9] ARM: dts: imx6q-sabrelite: add 2p5v and 3p3v
[PATCH v2 4/9] ARM: dts: imx6q-sabrelite: add sgtl5000 audio codec
[PATCH v2 5/9] ARM: mxc: convert audmux-v2 to a platform driver
[PATCH v2 6/9] ARM: mx31ads: add audmux device
[PATCH v2 7/9] ARM: mxc: move audmux-v2 to sound/soc/imx
[PATCH v2 8/9] ASoC: imx: add dt support for audmux-v2
[PATCH v2 9/9] ARM: imx6q-sabrelite: add audmux support

Thanks
Richard
