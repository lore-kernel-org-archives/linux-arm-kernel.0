From: richard.zhao@linaro.org (Richard Zhao)
Date: Wed, 14 Dec 2011 09:26:43 +0800
Subject: [PATCH V3 0/4] add imx6q sabrelite board support
Message-ID: <1323826007-17937-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since V1:
 - rename gpio labels
 - imx6q-sabrelite.dts: remove fec_mac and bootargs
 - add clock_frequency in cpu0 node to check max cpu frequency
 - add item in Kconfig in alpha order


[PATCH V3 1/4] dts/imx: rename gpio labels to consistent with hw
[PATCH V3 2/4] dts/imx: rename uart labels to consistent with hw
[PATCH V3 3/4] arm/imx6: add imx6q sabrelite board support
[PATCH V3 4/4] arm/imx6q-sabrelite: add enet phy ksz9021rn fixup

Thanks
Richard
