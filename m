From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Wed, 13 Aug 2014 17:03:24 +0800
Subject: [PATCH 0/2] Introduce hix5hd2 IR transmitter driver
Message-ID: <1407920606-18788-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guoxiong Yan (2):
  [media] rc: Add DT bindings for hix5hd2
  [media] rc: Introduce hix5hd2 IR transmitter driver

 .../devicetree/bindings/media/hix5hd2-ir.txt       |   19 ++
 drivers/media/rc/Kconfig                           |   11 +
 drivers/media/rc/Makefile                          |    1 +
 drivers/media/rc/ir-hix5hd2.c                      |  347 ++++++++++++++++++++
 4 files changed, 378 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/hix5hd2-ir.txt
 create mode 100644 drivers/media/rc/ir-hix5hd2.c

-- 
1.7.9.5
