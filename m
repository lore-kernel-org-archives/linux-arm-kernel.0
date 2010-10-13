From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 13 Oct 2010 20:47:00 +0900
Subject: [PATCH 0/2] ARM: SAMSUNG: Add Support Power Domain Control
Message-ID: <1286970422-15993-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support Power Domain Control based on Runtim PM.

Each Power Domain is represented by a Power Domain device and the devices
belong to these Power Domains should be set as a child device of the Power
Domain devices. The corresponding drivers of the devices should implement
Runtime PM to control the Power Domains.

NOTE: Depends on EINT and GPIOlib.

[PATCH 1/2] ARM: SAMSUNG: Add support for Power Domain control
[PATCH 2/2] ARM: S5PV310: Add support Power Domain
