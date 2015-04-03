From: tony@atomide.com (Tony Lindgren)
Date: Fri, 3 Apr 2015 16:49:18 -0700
Subject: [PATCH 03/14] clkdev: get rid of redundant clk_add_alias()
 prototype in linux/clk.h
In-Reply-To: <E1Ye593-0001B1-W4@rmk-PC.arm.linux.org.uk>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
 <E1Ye593-0001B1-W4@rmk-PC.arm.linux.org.uk>
Message-ID: <20150403234918.GD18048@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [150403 10:13]:
> clk_add_alias() is provided by clkdev, and is not part of the clk API.
> Howver, it is prototyped in two locations: linux/clkdev.h and
> linux/clk.h.  This is a mess.  Get rid of the redundant and unnecessary
> version in linux/clk.h.

Acked-by: Tony Lindgren <tony@atomide.com>
