From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 13 May 2012 23:18:59 +0800
Subject: [PATCH 0/2] A couple of pinctrl-mxs updates
Message-ID: <1336922341-7089-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The series consists of a couple of pinctrl-mxs driver updates, which
are required for mxs device tree support, so please queue them for
the upcoming merge window, if they look all good.  Thanks.

Regards,
Shawn

Shawn Guo (2):
  pinctrl: mxs: create group for pin config node
  pinctrl: mxs: skip gpio nodes for group creation

 drivers/pinctrl/pinctrl-mxs.c |   75 ++++++++++++++++++++++++++++-------------
 1 files changed, 51 insertions(+), 24 deletions(-)

-- 
1.7.5.4
