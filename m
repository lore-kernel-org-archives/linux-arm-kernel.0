From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue,  3 Oct 2017 14:53:28 +0100
Subject: [PATCH 0/3] ACPI/IORT: Clean-up/rework for v4.15
Message-ID: <1507038811-23382-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A three-patch series collection of backlog clean-ups/rework in
preparation for future code restructuring and features support.

Patch series depends on:

https://marc.info/?l=linux-arm-kernel&m=150696522211494&w=2

Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>

Lorenzo Pieralisi (3):
  ACPI/IORT: Remove leftover ACPI_IORT_SMMU_V3_PXM_VALID guard
  ACPI/IORT: Improve functions return type/storage class specifier
    indentation
  ACPI/IORT: Make platform devices initialization code SMMU agnostic

 drivers/acpi/arm64/iort.c | 83 ++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 44 deletions(-)

-- 
2.4.12
