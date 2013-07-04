From: Baohua.Song@csr.com (Barry Song)
Date: Thu, 4 Jul 2013 15:55:28 +0800
Subject: [PATCH 4/5] pinctrl: sirf: fix the checkpatch issue about indentation
In-Reply-To: <1372924529-5519-1-git-send-email-Baohua.Song@csr.com>
References: <1372924529-5519-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1372924529-5519-4-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <Rongjun.Ying@csr.com>

Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-sirf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index 0677e19..7186b46 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -306,13 +306,13 @@ static int sirfsoc_gpio_of_xlate(struct gpio_chip *gc,
        u32 *flags)
 {
        if (gpiospec->args[0] > SIRFSOC_GPIO_NO_OF_BANKS * SIRFSOC_GPIO_BANK_SIZE)
-               return -EINVAL;
+		return -EINVAL;
 
        if (gc != &sgpio_bank[gpiospec->args[0] / SIRFSOC_GPIO_BANK_SIZE].chip.gc)
-               return -EINVAL;
+		return -EINVAL;
 
        if (flags)
-               *flags = gpiospec->args[1];
+		*flags = gpiospec->args[1];
 
        return gpiospec->args[0] % SIRFSOC_GPIO_BANK_SIZE;
 }
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
