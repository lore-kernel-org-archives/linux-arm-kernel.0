From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Mar 2015 16:22:32 +0100
Subject: [PATCH v2] Mediatek PMIC wrapper support
Message-ID: <1426000954-7647-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Note: This is v2 of this series which contains the PMIC wrapper patches only,
the patches themselves have been posted as part of other series already]

This series adds support for the PMIC wrapper found on MT8135 and
MT8173 SoCs. No further compile time dependencies.

Changes since last version:

- Remove #define DEBUG
- Remove PMIC specific register writes
- Mention other SoCs which contain a PMIC wrapper aswell
