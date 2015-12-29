From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Tue, 29 Dec 2015 02:47:32 +0100
Subject: [PATCH 0/1 for 4.4-rc8] ARM: Fix broken USB support in sunxi_defconfig
Message-ID: <1451353653-17484-1-git-send-email-public_timo.s@silentcreek.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is a late patch aimed for 4.4-rc8 (or 4.4). It would be nice if this   
could make it into 4.4 in order to avoid unpleasent surprises (and
subsequent questions) with builds based on sunxi_defconfig. At the moment,
some boards (e.g. LeMaker BananaPi) are left with non-functional USB ports
as a newly added driver is required to power them.

Timo Sigurdsson (1):
  ARM: Fix broken USB support in sunxi_defconfig

 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
2.1.4
