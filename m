From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 24 Jan 2017 18:39:49 +0800
Subject: [PATCH 0/2] arch_timer: acpi: Add workaround for hisilicon-161010101
 erratum
Message-ID: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Introduce a general quirk framework for arch timer erratum in ACPI,
which use the oem information in GTDT table for platform specific
erratums, then add specific handler and data for hisilicon-161010101
erratum.

Hanjun Guo (2):
  arm64: arch_timer: acpi: Introduce a generic aquirk framework for
    erratum
  arch_timer: acpi: add hisi timer erratum data

 drivers/clocksource/arm_arch_timer.c | 58 ++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

-- 
1.7.12.4
