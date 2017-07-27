From: david.wu@rock-chips.com (David.Wu)
Date: Thu, 27 Jul 2017 20:44:42 +0800
Subject: [PATCH 05/11] net: stmmac: dwmac-rk: Add internal phy support
In-Reply-To: <20170624022954.GD4875@lunn.ch>
References: <1498192929-7519-1-git-send-email-david.wu@rock-chips.com>
 <1498193947-8011-1-git-send-email-david.wu@rock-chips.com>
 <20170624022954.GD4875@lunn.ch>
Message-ID: <24bc9102-d37f-1a63-ad7b-f69e8e38d848@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

? 2017/6/24 10:29, Andrew Lunn ??:
> If this is the PHY clock, should it actually be specified in the PHY
> binding? Can you read the PHY ID registers with this clock off?
If the phy clock is closed, we can not read the PHYID.
