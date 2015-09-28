From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Mon, 28 Sep 2015 13:34:36 +0800
Subject: [PATCH 0/2] to allow EFI_RTC can be selected on ARM64
Message-ID: <1443418478-8240-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I apart the modification into two parts, and use the same title and main
description for each part.

Zhen Lei (2):
  char/rtc: to allow EFI_RTC can be selected on ARM64
  arm64: to allow EFI_RTC can be selected on ARM64

 arch/arm64/Kconfig   | 2 +-
 drivers/char/Kconfig | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.5.0
