From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 13 Jun 2017 16:45:47 +0300
Subject: [PATCH 0/3] ARM: OMAP4: add support for some crypto features
Message-ID: <1497361550-4735-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds a few patches missing from Sebastian's series here:
https://lkml.org/lkml/2017/6/13/266

Only the sham patches in this series work standalone, the two
series should be combined together to apply properly and to avoid
any boot warnings (missing DT data for hwmods.)

-Tero
