From: yvo@apm.com (Y Vo)
Date: Fri, 29 May 2015 16:52:40 +0700
Subject: [PATCH v1] gpio: add ACPI support for APM X-Gene GPIO standby driver
Message-ID: <1432893161-3888-1-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ACPI support for APM X-Gene GPIO standby driver.

V1 change:
	- Remove check CONFIG_ACPI when call acpi_gpiochip_request_interrupts() function.
	- Add acpi_gpiochip_free_interrupts() function to unregister the interrupt.

Y Vo (1):
  gpio: xgene: add ACPI support for APM X-Gene GPIO standby driver

 drivers/gpio/gpio-xgene-sb.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)
