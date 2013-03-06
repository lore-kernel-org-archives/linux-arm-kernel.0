From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  6 Mar 2013 16:12:43 +0100
Subject: [PATCH 0/2] pinctrl: sunxi: Add missing pin functions
Message-ID: <1362582765-25251-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here is a patch that complete the functions array for the two sunxi SoCs
we have documentation and hardware for.

The only missing functions are the irq one, that will be eventually added
along with the external interrupt support.

Thanks,
Maxime

Maxime Ripard (2):
  pinctrl: sunxi: Add Allwinner A10 pin functions
  pinctrl: sunxi: Add Allwinner A13 pin functions

 drivers/pinctrl/pinctrl-sunxi.c |  972 +++++++++++++++++++++++++++++----------
 1 file changed, 740 insertions(+), 232 deletions(-)

-- 
1.7.10.4
