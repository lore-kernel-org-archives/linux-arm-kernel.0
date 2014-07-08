From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  8 Jul 2014 17:11:40 +0200
Subject: [PATCH 0/3] minor MSM cleanup
Message-ID: <1404832303-14850-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi MSM folks,

here are some weird things I found when looking through the mach-msm
folder, can you have a look at this and see if it's as unused as it
looks to me?

Linus Walleij (3):
  ARM: msm: delete dangling mahimahi board file
  ARM: msm: remove reference to MSM_SERIAL_DEBUGGER
  ARM: msm: delete dangling debug UART code

 arch/arm/mach-msm/board-mahimahi.c   | 83 ------------------------------------
 arch/arm/mach-msm/board-msm7x30.c    |  2 +-
 arch/arm/mach-msm/board-trout-gpio.c |  5 ---
 arch/arm/mach-msm/board-trout.c      |  5 ---
 4 files changed, 1 insertion(+), 94 deletions(-)
 delete mode 100644 arch/arm/mach-msm/board-mahimahi.c

-- 
1.9.3
