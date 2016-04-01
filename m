From: petr@barix.com (Petr Kulhavy)
Date: Fri,  1 Apr 2016 17:42:02 +0200
Subject: [PATCH 0/3] ARM: DTS: da850: add node for i2c1
Message-ID: <1459525325-25470-1-git-send-email-petr@barix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds I2C-1 device tree node for the da850 platform

I've borrowed the first patch of the series from David Lechner from MUSB as it
corrects the wrong addresses in the da850.dts files. The da850 was using the
physical addresses after the "@" rather than the <reg> addresses as the
convention says.

---
1.9.1
