From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Tue, 20 Jun 2017 12:37:15 +0530
Subject: [PATCH v2 0/2] acpi, gicv3-its, numa: Adding numa node mapping for ITS
Message-ID: <1497942437-1390-1-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI 6.2 have added SRAT subtable to define proximity domain for ITS
devices. This patchset updates acpi header file from acpica repo and
adds numa node mapping for ITS devices.

v2:
 - Incorporated comments from Lorenzo Pieralisi and Marc Zyngier.

v1: first patch

Ganapatrao Kulkarni (2):
  ACPICA: ACPI 6.2: Add support for new SRAT subtable
  acpi, gicv3-its, numa: Adding numa node mapping for gic-its units

 drivers/irqchip/irq-gic-v3-its.c | 76 +++++++++++++++++++++++++++++++++++++++-
 include/acpi/actbl1.h            | 12 ++++++-
 2 files changed, 86 insertions(+), 2 deletions(-)

-- 
1.8.1.4
