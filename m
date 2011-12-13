From: richard.zhao@linaro.org (Richard Zhao)
Date: Tue, 13 Dec 2011 14:25:23 +0800
Subject: [PATCH V2 0/7] imx: add imx6 sabrelite board
Message-ID: <1323757530-19402-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- add imx6q sabrelite board support
- add imx6q cpufreq support

Changes since V1:
 - rename gpio labels
 - imx6q-sabrelite.dts: remove fec_mac and bootargs
 - add clock_frequency in cpu0 node to check max cpu frequency
 - add item in Kconfig in alpha order

Thanks
Richard
