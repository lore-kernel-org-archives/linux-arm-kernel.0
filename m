From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 07 Jan 2011 17:57:45 +0100
Subject: [PATCH] ARM: S5PV210: Add GONI board setup for CIF camera support
Message-ID: <1294419468-13700-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the following patch series introduces changes in GONI board setup file
required for the CIF camera sensor driver.
The first patch adds the I2C0 bus driver, the second one adds the regulator
supply definitions and the third one just increases virtual size
of the framebuffer window 0 for preview double buffering.


The patch series contains:

[PATCH 1/3] ARM: S5PV210: Enable I2C0 bus on GONI board
[PATCH 2/3] ARM: S5PV210: Add supplies for CIF camera on GONI board
[PATCH 3/3] ARM: S5PV210: Change framebuffer window 0 size on GONI

Created against kgene-for-next branch at:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 


Regards,
Sylwester


--
Sylwester Nawrocki
Samsung Poland R&D Center
