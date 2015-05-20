From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 May 2015 15:32:43 +0200
Subject: [PATCH v2] arm64: dts: Mediatek: MT8173 updates
Message-ID: <1432128766-4445-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains dts updates for Mediatek MT8173 for Linux 4.2.
The clock code and the PMIC wrapper are sitting in Linux next, this
series adds the dts updates to make use of this code.

Changes since v1:

- rebase on Matthias' tree
- use lowercase hex numbers
- alphabetise #includes

Sascha
