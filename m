From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 16 May 2017 01:28:31 +0200
Subject: [PATCH 0/2] Armada 8040 MachiatoBin and DB improvements
Message-ID: <1494890913-8360-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This very short series apply improvements to two Armada 8040 boards,
adding missing 'chosen' node for MachiatoBin and some of the interfaces
hitherto not present in device trees, but yet supported in the kernel.

I'm looking forward to any comments or remarks.

Best regards,
Marcin

Marcin Wojtas (2):
  arm64: marvell: dts: fill MachiatoBin board description
  arm64: marvell: dts: add second 1G port on the Armada 8040 DB

 arch/arm64/boot/dts/marvell/armada-8040-db.dts    | 16 +++++++++++
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 34 +++++++++++++++++++++++
 2 files changed, 50 insertions(+)

-- 
1.8.3.1
