From: davem@davemloft.net (David Miller)
Date: Wed, 06 Dec 2017 15:46:22 -0500 (EST)
Subject: [PATCH] net: ethernet: arc: fix error handling in
 emac_rockchip_probe
In-Reply-To: <20171206172433.3457-1-branislav@radocaj.org>
References: <20171206172433.3457-1-branislav@radocaj.org>
Message-ID: <20171206.154622.1837920620671638254.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Branislav Radocaj <branislav@radocaj.org>
Date: Wed,  6 Dec 2017 18:24:33 +0100

>     If clk_set_rate() fails, we should disable clk
>     before return.
> 
>     Found by Linux Driver Verification project (linuxtesting.org).
> 
>     Signed-off-by: Branislav Radocaj <branislav@radocaj.org>

Please eliminate this indentation of your commit message and
resubmit.

Thank you.
