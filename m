From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 20 Feb 2012 12:26:04 +0200
Subject: [PATCHv10 0/4] omap smps regulator support
Message-ID: <1329733568-26676-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just some cosmetic changes compared to previous version:

- dropped out '[patchv9 4/5] regulator: twl4030: add support for external
  controller', as this was accepted for merge by Mark
- changed names of regulators from VDD1 / VDD2 -> vdd_mpu_iva / vdd_core
  in patch 3
- added document codes for TWL data manuals used as reference to commit log
  in patch 3

-Tero
