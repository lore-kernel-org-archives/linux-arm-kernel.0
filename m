From: threeway@gmail.com (Steev Klimaszewski)
Date: Tue, 30 Dec 2014 00:55:47 -0600
Subject: [PATCH] Add USB_EHCI_EXYNOS to mutli_v7_defconfig
Message-ID: <1419922548-6320-1-git-send-email-steev@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB_EHCI_EXYNOS to enable USB support on Exynos platforms.  This fixes the
issue where networking and USB doesn't work on an ODROID-U3.

Steev Klimaszewski (1):
  Add USB_EHCI_EXYNOS to multi_v7_defconfig

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
2.2.1
