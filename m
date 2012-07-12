From: dinguyen@altera.com (dinguyen at altera.com)
Date: Thu, 12 Jul 2012 12:26:14 -0500
Subject: [RFC PATCHv2 0/2]arm: socfpga: Add initial support for Altera's
 SOCFPGA HW
Message-ID: <1342113976-27140-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

This patch series add minimal support for Altera's SOCFPGA hardward.

Changes since v1:
- Incorporate changes suggested by Pavel Machek, Thommas Petazzoni,
  Arnd Bergmann, and Rob Herring
- Reduce the patch to a make as much use of DTS as possible


Dinh Nguyen (2):
  ARM: socfpga: initial support for Altera's SOCFPGA platform.
  ARM: socfpga: Add board support for Altera's SOCFPGA Cyclone 5 HW

-- 
1.7.9.5
