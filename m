From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 24 Jul 2014 20:59:14 +0800
Subject: [PATCH 0/3] ACPICA updates for ACPI 5.1 MADT, FADT,
 GTDT (Just for patch review)
Message-ID: <1406206757-15512-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the patch set to update ACPICA for MADT, FADT, GTDT in
ACPI 5.1. These patches are only for review purpose, ACPICA
patches will have there own special upstream process, it will be
handled by Bob and Lv.

Bob, Lv, please ignore this patch set since you are working on
them now, it just for people to undstand the later ARM64 ACPI
core patches better and for temporary test purpose. I will rebase
my patch set once new version of ACPICA is released, thanks.

Hanjun Guo (2):
  ACPI / ACPICA: Introduce ARM Boot Architecture Flags in FADT
  ACPI / ACPICA: Add GTDT support updated by ACPI 5.1

Tomasz Nowicki (1):
  ACPI / ACPICA: Add new features for MADT which introduced by ACPI 5.1

 include/acpi/actbl.h  |   12 ++++--
 include/acpi/actbl1.h |   40 +++++++++++++++++---
 include/acpi/actbl3.h |   99 ++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 129 insertions(+), 22 deletions(-)

-- 
1.7.9.5
