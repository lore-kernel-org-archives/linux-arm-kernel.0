From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 05 Jul 2010 11:16:53 +0200
Subject: [PATCH v2] Samsung Aquila & GONI update
Message-ID: <1278321416-32524-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This short patch series adds basic framebuffer defintion to Samsung GONI
board as well as PMIC8998 support for both Samsung Aquila and GONI
boards. MAX8998 PMIC driver has been accepted by regulator subsystem
maintainers and is already available in the 'next' kernel tree (see
commit 8d017ab9f81089cb5ffde0e354d13130c1c19999). 

Changes since v1:
- removed all consumer entries, will be readded with aproperiate devices
(suggested by Mark Brown)

The series contains the following patches:

[PATCH 1/3] arm: s5pv210: GONI: add support for framebuffer
[PATCH 2/3] arm: s5pv210: Aquila: add support for MAX8998 PMIC
[PATCH 3/3] arm: s5pv210: GONI: add support for MAX8998 PMIC

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
