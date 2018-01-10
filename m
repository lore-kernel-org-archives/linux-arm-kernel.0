From: davem@davemloft.net (David Miller)
Date: Wed, 10 Jan 2018 15:41:13 -0500 (EST)
Subject: [PATCH net-next 2/2 v10] net: ethernet: Add a driver for
 Gemini gigabit ethernet
In-Reply-To: <20180109221053.927-2-linus.walleij@linaro.org>
References: <20180109221053.927-1-linus.walleij@linaro.org>
 <20180109221053.927-2-linus.walleij@linaro.org>
Message-ID: <20180110.154113.1759667248487481665.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue,  9 Jan 2018 23:10:53 +0100

> The Gemini ethernet has been around for years as an out-of-tree
> patch used with the NAS boxen and routers built on StorLink
> SL3512 and SL3516, later Storm Semiconductor, later Cortina
> Systems. These ASICs are still being deployed and brand new
> off-the-shelf systems using it can easily be acquired.
> 
> The full name of the IP block is "Net Engine and Gigabit
> Ethernet MAC" commonly just called "GMAC".
> 
> The hardware block contains a common TCP Offload Enginer (TOE)
> that can be used by both MACs. The current driver does not use
> it.
> 
> Cc: Tobias Waldvogel <tobias.waldvogel@gmail.com>
> Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied.
