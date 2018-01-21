From: davem@davemloft.net (David Miller)
Date: Sun, 21 Jan 2018 18:06:01 -0500 (EST)
Subject: [PATCH] net: gemini: Depend on HAS_IOMEM
In-Reply-To: <20180121131541.4337-1-linus.walleij@linaro.org>
References: <20180121131541.4337-1-linus.walleij@linaro.org>
Message-ID: <20180121.180601.1766576603476093870.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 21 Jan 2018 14:15:41 +0100

> The zeroday builder notices that since Usermode Linux does not
> have IO memory, the build fails for them when selecting everything
> it can enable.
> 
> As the driver is clearly using memory-mapped registers to access
> the network adapter, we add depends on HAS_IOMEM to solve this
> problem.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thank you.
