From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 1 Apr 2013 16:14:17 +0530
Subject: Query regarding clk framework - from .set_rate api
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC3E7C3@DBDE01.ent.ti.com>
References: <79CD15C6BA57404B839C016229A409A83EC3E7C3@DBDE01.ent.ti.com>
Message-ID: <51596501.1020904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> Where, the clk_set_rate() seems to be not working, and that's true
> with the current implementation of OMAP/AM33xx clock tree,
> as the CLK_SET_RATE_PARENT flag is not set to any of the clock nodes.
> 
> Please note that I am using DEFINE_STRUCT_CLK() macro for defining clocks
> And which doesn't allow you to specify the flags.

Use DEFINE_STRUCT_CLK_FLAGS() then. Its already used in AM33xx clock tree.
