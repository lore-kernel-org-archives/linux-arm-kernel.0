From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 21 Sep 2018 15:09:48 +0200
Subject: [GIT PULL] STM32 defconfig changes for v4.20 #1
Message-ID: <000b0ae8-a88d-9e0a-e8cc-4ec381817db0@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof and Kevin,

Please consider this first round of STM32 defconfig updates for v4.20.
This time it concerns only multi_v7_defconfig.

Thanks.
Alex

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-defconfig-for-v4.20-1

for you to fetch changes up to 4c736c22d954c81d430558ff62738a35f96f29da:

   ARM: multi_v7_defconfig: enable backlight gpio (2018-09-21 14:59:29 
+0200)

----------------------------------------------------------------
STM32 defconfig updates for v4.20, round 1

Highlights:
----------

In multi_v7_defconfig, add support of:

-STM32 SPI (module)
-STM32 DRM and MIPI DSI (modules)
-Pannels OTM8009A and RM68200 (modules)
-Enable backlight gpio

----------------------------------------------------------------
Amelie Delaunay (1):
       ARM: multi_v7_defconfig: enable STM32 SPI

Yannick Fertr? (3):
       ARM: multi_v7_defconfig: enable STM32 DRM and MIPI DSI support
       ARM: multi_v7_defconfig: enable panels OTM8009A and RM68200
       ARM: multi_v7_defconfig: enable backlight gpio

  arch/arm/configs/multi_v7_defconfig | 6 ++++++
  1 file changed, 6 insertions(+)
