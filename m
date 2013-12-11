From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 11 Dec 2013 16:35:48 +0800
Subject: [GIT PULL][for 3.14] pull request from pxa
Message-ID: <52A823E4.6070208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Olof/Kevin,

Please help to merge the pull request for pxa.


Best Regards
Haojian

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git 
tags/pxa-for-3.14

for you to fetch changes up to 8a53a1194f1cc870de0ab9db1728b1ecab770925:

   ARM: pxa: remove IRQF_DISABLED (2013-12-11 15:36:24 +0800)

----------------------------------------------------------------
Dmitry Eremin-Solenikov (1):
       arm: pxa: tosa: fix keys mapping

Michael Opdenacker (1):
       ARM: pxa: remove IRQF_DISABLED

Mike Dunn (2):
       PWM: PXA: add device tree support to PWM driver
       PXA: add PWM nodes to pxa27x.dtsi

Sergei Ianovich (1):
       ARM: pxa: prevent PXA270 occasional reboot freezes

Thierry Reding (1):
       ARM: pxa: Remove unused variables

  Documentation/devicetree/bindings/pwm/pxa-pwm.txt |  30 
+++++++++++++++++++++++++++
  arch/arm/boot/dts/pxa27x.dtsi                     |  24 
++++++++++++++++++++++
  arch/arm/mach-pxa/am200epd.c                      |   3 +--
  arch/arm/mach-pxa/am300epd.c                      |   3 +--
  arch/arm/mach-pxa/em-x270.c                       |   3 +--
  arch/arm/mach-pxa/irq.c                           |   4 ----
  arch/arm/mach-pxa/magician.c                      |   2 +-
  arch/arm/mach-pxa/mainstone.c                     |   2 +-
  arch/arm/mach-pxa/pcm990-baseboard.c              |   2 +-
  arch/arm/mach-pxa/reset.c                         |   8 +++++++-
  arch/arm/mach-pxa/sharpsl_pm.c                    |   8 ++++----
  arch/arm/mach-pxa/time.c                          |   2 +-
  arch/arm/mach-pxa/tosa.c                          | 102 
++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------
  arch/arm/mach-pxa/trizeps4.c                      |   3 +--
  arch/arm/plat-pxa/dma.c                           |   2 +-
  drivers/pwm/pwm-pxa.c                             |  52 
++++++++++++++++++++++++++++++++++++++++++++++-
  16 files changed, 176 insertions(+), 74 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt
