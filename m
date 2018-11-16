From: maxime.chevallier@bootlin.com (Maxime Chevallier)
Date: Fri, 16 Nov 2018 17:05:21 +0100
Subject: [PATCH 4/5] phy: mvebu-cp110-comphy: convert to use eth phy
 mode and submode
In-Reply-To: <20181108003617.10334-5-grygorii.strashko@ti.com>
References: <20181108003617.10334-1-grygorii.strashko@ti.com>
 <20181108003617.10334-5-grygorii.strashko@ti.com>
Message-ID: <20181116170521.11ee68e9@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Grygorii,

On Wed, 7 Nov 2018 18:36:16 -0600
Grygorii Strashko <grygorii.strashko@ti.com> wrote:

>Convert mvebu-cp110-comphy PHY driver to use recently introduced
>PHY_MODE_ETHERNET and phy_set_mode_ext().

I gave it a quick test on MacchiatoBin, it works fine and the automatic
mode switching in the comphy happens as expected, so :

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

>Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Maxime Chevallier, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
