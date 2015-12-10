From: lho@apm.com (Loc Ho)
Date: Thu, 10 Dec 2015 14:19:15 -0700
Subject: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
Message-ID: <1449782357-22982-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add APM X-Gene ACPI I2C device support. These patches follow
the same implementation as AMD I2C driver - changes in ACPI APD
and Designware I2C drivers.

v2:
* Spilt the acpi_apd change with defines for AMD and X-Gene I2C's

Signed-off-by: Loc Ho <lho@apm.com>
---
Loc Ho (2):
  acpi:apd: Add APM X-Gene ACPI I2C device support
  i2c:dw: Add APM X-Gene ACPI I2C device support

 drivers/acpi/acpi_apd.c                     |   16 +++++++++++++++-
 drivers/i2c/busses/i2c-designware-platdrv.c |    1 +
 2 files changed, 16 insertions(+), 1 deletions(-)
