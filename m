From: davem@davemloft.net (David Miller)
Date: Tue, 05 Jul 2011 19:48:54 -0700 (PDT)
Subject: [PATCH v2 0/3] Add device tree probe support for imx fec driver
In-Reply-To: <1309878839-25743-1-git-send-email-shawn.guo@linaro.org>
References: <1309878839-25743-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110705.194854.1875695946300840388.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>
Date: Tue, 5 Jul 2011 23:13:56 +0800

> The first two patches are a little off topic.  Patch #1 adds a helper
> function of_get_phy_mode into of_net, and #2 converts ibm_newemac net
> driver to use this helper function.  Patch #3 is the actual one adding
> tree probe support for imx fec driver, with of_get_phy_mode being used.
> 
> Changes since v1:
>  * Address review comments given by Grant
>  * Add patch #1 and #2
> 
> Shawn Guo (3):
>       dt/net: add helper function of_get_phy_mode
>       net: ibm_newemac: convert it to use of_get_phy_mode
>       net/fec: add device tree probe support

All applied to net-next-2.6, thanks.
