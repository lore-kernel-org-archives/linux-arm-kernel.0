From: lho@apm.com (Loc Ho)
Date: Mon,  7 Dec 2015 17:16:12 -0700
Subject: [PATCH 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
Message-ID: <1449533774-22672-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add APM X-Gene ACPI I2C device support. These patches follow
the same implementation as AMD I2C driver - changes in ACPI APD 
and Designware I2C drivers.

Signed-off-by: Loc Ho <lho@apm.com>
---
Loc Ho (2):
  acpi:apd: Add APM X-Gene ACPI I2C device support
  i2c:dw: Add APM X-Gene ACPI I2C device support

 drivers/acpi/acpi_apd.c                     |    8 +++++++-
 drivers/i2c/busses/i2c-designware-platdrv.c |    1 +
 2 files changed, 8 insertions(+), 1 deletions(-)
