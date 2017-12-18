From: davem@davemloft.net (David Miller)
Date: Mon, 18 Dec 2017 13:25:13 -0500 (EST)
Subject: [PATCH net-next v3 0/7] net: phy: meson-gxl: clean-up and
 improvements
In-Reply-To: <20171218094446.31912-1-jbrunet@baylibre.com>
References: <20171218094446.31912-1-jbrunet@baylibre.com>
Message-ID: <20171218.132513.849171657471096781.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 18 Dec 2017 10:44:39 +0100

> This patchset adds defines for the control registers and helpers to access
> the banked registers. The goal being to make it easier to understand what
> the driver actually does.
> Then CONFIG_A6 settings is removed since this statement was without effect
> Finally interrupt support is added, speeding things up a little
> 
> This series has been tested on the libretech-cc and khadas VIM
> 
> Changes since v2 [0]:
> Drop LPA corruption fix which has been merged through net. Apart from this,
> series remains the same.
> 
> [0]: https://lkml.kernel.org/r/20171207142715.32578-1-jbrunet at baylibre.com

Series applied, thanks.
