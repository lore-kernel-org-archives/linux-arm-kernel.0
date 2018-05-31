From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Thu, 31 May 2018 20:41:44 +0800
Subject: [PATCH v1 0/2] Add NOTIFY_SEI notification type support
Message-ID: <1527770506-8076-1-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series patch is separated from https://www.spinics.net/lists/kvm/msg168917.html

1. CPI 6.1 adds support for NOTIFY_SEI as a GHES notification mechanism, so this patch supports this
   notification in software

Dongjiu Geng (2):
  ACPI / APEI: Add SEI notification type support for ARMv8
  arm64: handle NOTIFY_SEI notification by the APEI driver

 arch/arm64/kernel/traps.c | 15 ++++++++++++++
 drivers/acpi/apei/Kconfig | 15 ++++++++++++++
 drivers/acpi/apei/ghes.c  | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes.h       |  1 +
 4 files changed, 84 insertions(+)

-- 
1.9.1
