From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 14 Jul 2010 10:16:53 +0200
Subject: [PATCH v3] Samsung Aquila & GONI update
Message-ID: <1279095416-24871-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This short patch series adds basic framebuffer defintion to Samsung GONI
board as well as PMIC8998 support for both Samsung Aquila and GONI
boards. MAX8998 PMIC driver has been accepted by regulator subsystem
maintainers and is already available in the 'next' kernel tree (see
commit 8d017ab9f81089cb5ffde0e354d13130c1c19999). 

Changes since v2:
- cleaned some tabs&spaces errors, renamed max8998_platform_data to
  {aquila,goni}_max8998_pdata
- removed some superfluous includes
(suggested by Kukjin Kim) 

Changes since v1:
- removed all consumer entries, will be readded with aproperiate devices
(suggested by Mark Brown)

The series contains the following patches:

[PATCH 1/3] ARM: S5PV210: GONI: add support for framebuffer
[PATCH 2/3] ARM: S5PV210: Aquila: add support for MAX8998 PMIC
[PATCH 3/3] ARM: S5PV210: GONI: add support for MAX8998 PMIC

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
