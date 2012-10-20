From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 20 Oct 2012 23:27:34 +0800
Subject: [GIT PULL][for 3.8] pull request of serial branch from arch pxa git
 tree
Message-ID: <CAN1soZzVwMK5_e=tjvuOm_Wf=ybA07O1uL9x_CVU-ATsp7z7Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof & Arnd,

Please help to merge upload/serial branch in arch pxa git tree.

Best Regards
Haojian

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git upload/serial

for you to fetch changes up to b7c5cb4fcb4ab81f1b3d7e20545ad29372a37a9e:

  tty: serial: KGDB support for PXA (2012-10-20 23:07:37 +0800)

----------------------------------------------------------------
Denis V. Lunev (1):
      tty: serial: KGDB support for PXA

 drivers/tty/serial/pxa.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
