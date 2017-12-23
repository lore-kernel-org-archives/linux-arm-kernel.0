From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 23 Dec 2017 22:36:56 +0100
Subject: [PATCH 0/3] Pinctrl-Rockchip: Adjustments for six functions
Message-ID: <323697d0-e1e8-8d3b-1070-f481cfa30b9a@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 23 Dec 2017 22:33:44 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete error messages for a failed memory allocation in two functions
  Improve a size determination in rockchip_pinctrl_probe()
  Fix a typo in four comment lines

 drivers/pinctrl/pinctrl-rockchip.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

-- 
2.15.1
