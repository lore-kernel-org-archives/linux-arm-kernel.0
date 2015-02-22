From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 22 Feb 2015 13:15:28 +0100
Subject: [PATCH] MFD: Mediatek MT6397 base support
Message-ID: <1424607330-1829-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the Mediatek MT6397 PMIC. It adds the register defines,
registration of child devices and interrupt support.

Lee, this series contains only the MFD parts without further dependencies. Please
take through your tree.

Sascha
