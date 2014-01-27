From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 27 Jan 2014 14:01:29 +0800
Subject: [PATCH] pinctrl: sirf: correct the pin index of ac97_pins group
Message-ID: <1390802489-2535-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

according to datasheet and ac97_muxmask assignment, ac97_pins should be
corrected.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-prima2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-prima2.c b/drivers/pinctrl/sirf/pinctrl-prima2.c
index 37b4265..dde0285 100644
--- a/drivers/pinctrl/sirf/pinctrl-prima2.c
+++ b/drivers/pinctrl/sirf/pinctrl-prima2.c
@@ -413,7 +413,7 @@ static const struct sirfsoc_padmux ac97_padmux = {
 	.funcval = 0,
 };
 
-static const unsigned ac97_pins[] = { 33, 34, 35, 36 };
+static const unsigned ac97_pins[] = { 43, 44, 45, 46 };
 
 static const struct sirfsoc_muxmask spi1_muxmask[] = {
 	{
-- 
1.7.5.4
