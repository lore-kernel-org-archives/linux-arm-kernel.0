From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Mon, 3 Aug 2015 14:59:56 +0800
Subject: [PATCH 0/2] drivers: PL061: Add platform driver probing support
Message-ID: <1438585198-8764-1-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

According to ACPI SPEC, it supports ARM boards to use "GPIO-signaled
ACPI Events". These events can be used for input events. And to QEMU, it
uses GPIO PL061 controller for input events.

These two patches add platform driver support for PL061 probed by DT or
ACPI.

Shannon Zhao (2):
  drivers: PL061: add support for platform driver probing
  drivers: PL061: add ACPI probing for PL061

 drivers/gpio/gpio-pl061.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

-- 
2.0.4
