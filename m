From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 27 Apr 2012 17:06:53 +0800
Subject: [GIT PULL][for 3.5] pull request from arch-pxa keyboard
Message-ID: <CAN1soZz+nbDrfsoNLAV0WfBz7rV+hRR_NP8QrWKONROANNLBbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof & Arnd,

Please help to pull keyboard branch from arch-pxa git tree.

The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git keyboard

Chao Xie (4):
      Input: pxa27x_keypad keep clock on as wakeup source
      Input: pxa27x_keypad bug fix for direct_key_mask
      Input: pxa27x_keypad direct key may be low active
      Input: pxa27x_keypad add choice to set direct_key_mask

 arch/arm/plat-pxa/include/plat/pxa27x_keypad.h |    4 ++
 drivers/input/keyboard/pxa27x_keypad.c         |   52 +++++++++++++++++------
 2 files changed, 42 insertions(+), 14 deletions(-)

Regards
Haojian
