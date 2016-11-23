From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Wed, 23 Nov 2016 16:07:54 +0800
Subject: [RFC V2:PATCH 0/2] add reset-hi3660
In-Reply-To: <Arnd Bergmann <arnd@arndb.de>,>
References: <Arnd Bergmann <arnd@arndb.de>,>
Message-ID: <1479888476-13138-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Considering Arnd and Philipp suggestions, 
move reset register to dts as table instead of dts header in case of ABI issue

Zhangfei Gao (2):
  dt-bindings: Document the hi3660 reset bindings
  reset: hisilicon: add reset-hi3660

 .../bindings/reset/hisilicon,hi3660-reset.txt      |  51 ++++++++
 drivers/reset/hisilicon/Kconfig                    |   7 +
 drivers/reset/hisilicon/Makefile                   |   1 +
 drivers/reset/hisilicon/reset-hi3660.c             | 144 +++++++++++++++++++++
 4 files changed, 203 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
 create mode 100644 drivers/reset/hisilicon/reset-hi3660.c

-- 
2.7.4
