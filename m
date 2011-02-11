From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 11 Feb 2011 18:27:50 +0100
Subject: [PATCH v2] ARM: S5PV210: Add GONI board setup for CIF camera support
Message-ID: <1297445273-3829-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the following patch series introduces changes in GONI board setup file
required for the CIF camera sensor driver.
The first patch adds the I2C0 bus driver, the second one adds the regulator
supply definitions and the third one just increases virtual size
of the framebuffer window 0 to enable double-buffering.
The added regulator supplies are also a subset of the supplies of the high
resolution camera which that reference board is equipped with.

Changes since v1:
 - removed unnecessary "select CONFIG_S3C_DEV_I2C0"


The patch series contains:

[PATCH 1/3] ARM: S5PV210: Enable I2C0 bus on GONI board
[PATCH 2/3] ARM: S5PV210: Add supplies for CIF camera on GONI board
[PATCH 3/3] ARM: S5PV210: Change framebuffer window 0 size on GONI

Created against for-next branch at:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 


Regards,
--
Sylwester Nawrocki
Samsung Poland R&D Center
