From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 19:44:53 +0100
Subject: [PATCH 1/7] clk: mvebu: init all mvebu clock types from
 mvebu_clocks_init()
In-Reply-To: <20121119182513.GR14643@lunn.ch>
References: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1353343963-23034-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121119182513.GR14643@lunn.ch>
Message-ID: <20121119194453.444ce3fc@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Mon, 19 Nov 2012 19:25:13 +0100, Andrew Lunn wrote:

> You have a minor problem here.
> 
> obj-$(CONFIG_MVEBU_CLK_GATING)  += clk-gating-ctrl.o
> 
> There is no guarantee mvebu_clk_gating_init() exists. In fact, orion5x
> does not have gated clocks, so won't be selecting this option.

Correct, I will do the same as I did in PATCH 2/7 for the CPU clocks.

Thanks for the review,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
