From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 12 Nov 2014 13:03:15 -0800
Subject: [PATCH 3.19 0/2] ARM: multi_v7_defconfig: Enable Broadcom Cygnus
Message-ID: <1415826197-6748-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

These two patches enable support for the Broadcom Cygnus SoC in the
multi_v7_defconfig and also remove one level of menuconfig.

Thanks!

Ray Jui (1):
  ARM: multi_v7_defconfig: Enable Broadcom Cygnus

Scott Branden (1):
  ARM: multi_v7_defconfig: remove one level of menu from Kconfig

 arch/arm/configs/multi_v7_defconfig | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

-- 
1.9.1
