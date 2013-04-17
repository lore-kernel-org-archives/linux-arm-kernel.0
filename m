From: dmurphy@ti.com (Dan Murphy)
Date: Wed, 17 Apr 2013 14:09:37 -0500
Subject: [PATCH] Fix omap4 panda LED definitions
Message-ID: <1366225778-6083-1-git-send-email-dmurphy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LED GPIOs between the 4430 (a1-a4) and 4460 (es) panda boards
are different.  This patch abstracts the LED definitions into the 
respective board files.
