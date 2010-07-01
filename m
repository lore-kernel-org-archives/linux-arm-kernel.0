From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 01 Jul 2010 08:07:43 +0200
Subject: [PATCH] Samsung Aquila & GONI update
Message-ID: <1277964466-23891-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This short patch series adds basic framebuffer defintion to Samsung GONI
board as well as PMIC8998 support for both Samsung Aquila and GONI
boards. MAX8998 PMIC driver has been accepted by regulator subsystem
maintainers and is already available in the 'next' kernel tree (see
commit 8d017ab9f81089cb5ffde0e354d13130c1c19999). 

The series contains the following patches:

[PATCH 1/3] arm: s5pv210: GONI: add support for framebuffer
[PATCH 2/3] arm: s5pv210: Aquila: add support for MAX8998 PMIC
[PATCH 3/3] arm: s5pv210: GONI: add support for MAX8998 PMIC

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
