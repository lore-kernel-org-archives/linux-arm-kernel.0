From: fkan@apm.com (Feng Kan)
Date: Tue,  7 Jan 2014 14:50:41 -0800
Subject: [PATCH V2 6/6] acpi: platform: add ACPI code for X-Gene reboot
 platform driver.
In-Reply-To: <1389135041-16062-1-git-send-email-fkan@apm.com>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
Message-ID: <1389135041-16062-7-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ACPI code for X-Gene reboot platform driver.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 drivers/acpi/acpi_platform.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index dbfe49e..9fe1d4f 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -37,6 +37,9 @@ static const struct acpi_device_id acpi_platform_device_ids[] = {
 	{ "INT33C8" },
 	{ "80860F28" },
 
+	/* APM X-Gene */
+	{ "APMC0D08" },
+
 	{ }
 };
 
-- 
1.7.6.1
