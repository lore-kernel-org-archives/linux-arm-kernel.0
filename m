From: slemieux.tyco@gmail.com (slemieux.tyco at gmail.com)
Date: Thu, 18 Feb 2016 16:35:22 -0500
Subject: [PATCH 0/2] arm: lpc32xx: restart: add support for soft reset
Message-ID: <1455831324-8909-1-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

The LPC32xx provide the capability to perform a soft or hard reset;
a soft reset will no reset the external peripheral
(i.e. RESOUT_N output not asserted).

The default behavior (i.e. hard reset) remain unchanged.

Sylvain Lemieux (2):
  arm: lpc32xx: restart: add support for soft reset
  arm: lpc32xx: restart: support "cmd" from userspace

 arch/arm/mach-lpc32xx/common.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

-- 
1.8.3.1
