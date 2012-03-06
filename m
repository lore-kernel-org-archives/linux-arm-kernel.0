From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 6 Mar 2012 15:06:57 +0800
Subject: [GIT PULL][for v3.4]pull request from arch-pxa tree with rtc branch
Message-ID: <CAN1soZxSpnDJCiz-5_PiHcb+zoR+X0b2VLyANLY0om0MDo+YYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please help to pull this patch from arch-pxa git with rtc branch. I
have to put it into rtc branch since I met patch conflict on v3.3-rc6.
It seems that putting it into rtc branch with previous rtc patches is
a better choice.

Best Regards
Haojian

The following changes since commit 4128e27584f58bce9f56a9a0346650c94a651332:

  ARM: mmp: enable rtc in pxa910 (2012-02-28 11:23:09 +0800)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git rtc

Haojian Zhuang (1):
      rtc: sa1100: add OF support

 drivers/rtc/rtc-sa1100.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)
