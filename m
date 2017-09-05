From: isubramanian@apm.com (Iyappan Subramanian)
Date: Tue,  5 Sep 2017 11:16:29 -0700
Subject: [PATCH 0/3] drivers: net: xgene: Misc bug fixes
Message-ID: <1504635392-19089-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set fixes bugs related to handling the case for ACPI for,
reading and programming tx/rx delay values.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---

Iyappan Subramanian (2):
  drivers: net: xgene: Read tx/rx delay for ACPI
  drivers: net: xgene: Remove return statement from void function

Quan Nguyen (1):
  drivers: net: xgene: Configure tx/rx delay for ACPI

 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c   | 7 ++-----
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 6 ++----
 2 files changed, 4 insertions(+), 9 deletions(-)

-- 
2.7.4
