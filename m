From: yixun.lan@amlogic.com (Yixun Lan)
Date: Wed, 9 May 2018 22:08:25 +0000
Subject: [PATCH 0/2] pinctrl: nand: meson: fix missing data pins
Message-ID: <20180509220827.22286-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus
   We found the data pins of NAND controller are actually mising from
the nand pinctrl group in the GXBB, GXL SoC driver, these two patches
will fix these issue.
   I have prepared the two patches separated with different Fix tag,
but I can squash them into one patch if you prefer, since the meson nand
driver has never been pushed into mainline (so probably the Fix tag is
useless).
   Btw, the patches are formated on top your 'for-next' branch,
and I'm fine with this merged as for-next.

   Thanks

Yixun Lan (2):
  pinctrl: nand: meson-gxbb: fix missing data pins
  pinctrl: nand: meson-gxl: fix missing data pins

 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 4 ++--
 drivers/pinctrl/meson/pinctrl-meson-gxl.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.0
