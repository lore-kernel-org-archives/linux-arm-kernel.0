From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 17 Mar 2015 11:14:32 +0100
Subject: [PATCH v3] Mediatek PMIC wrapper support
Message-ID: <1426587274-7810-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the PMIC wrapper found on MT8135 and
MT8173 SoCs. This has been sent several times already as part of
different series, this time broken out as a series only containing
the wrapper code. No further compile time dependencies.

Changes since v2:

- remove stray debug printk
- change MODULE_LICENSE to GPL v2 as stated in the header

Changes since v1:

- Remove #define DEBUG
- Remove PMIC specific register writes
- Mention other SoCs which contain a PMIC wrapper aswell

Sascha
