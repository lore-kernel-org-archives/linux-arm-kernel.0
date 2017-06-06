From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Tue,  6 Jun 2017 16:17:43 +0530
Subject: [PATCH v2 0/2] acpi/iort,
 numa: Add numa node mapping for smmuv3 devices
Message-ID: <1496746065-11082-1-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM IORT specification(rev. C) has added  provision to define proximity
domain in SMMUv3 IORT table. Adding required code to parse Proximity
domain and set numa_node of smmv3 platform devices.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

v2:
  - Changed as per Lorenzo Pieralisi and Hanjun Guo suggestions.

v1:
  - Initial patch

Ganapatrao Kulkarni (2):
  acpica: iort: Update SMMUv3 header for proximity domain mapping
  acpi/iort, numa: Add numa node mapping for smmuv3 devices

 drivers/acpi/arm64/iort.c | 20 ++++++++++++++++++++
 include/acpi/actbl2.h     |  4 ++++
 2 files changed, 24 insertions(+)

-- 
1.8.1.4
