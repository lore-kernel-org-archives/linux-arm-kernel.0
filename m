From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 May 2017 15:14:46 -0700
Subject: [PATCHv3 2/4] clk: ti: add support for clkctrl clocks
In-Reply-To: <1495036209-11298-3-git-send-email-t-kristo@ti.com>
References: <1495036209-11298-1-git-send-email-t-kristo@ti.com>
 <1495036209-11298-3-git-send-email-t-kristo@ti.com>
Message-ID: <20170519221445.GJ10472@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [170517 08:54]:
> Previously, hwmod core has been used for controlling the hwmod level
> clocks directly. This has certain drawbacks, like being unable to share
> the clocks for multiple users, missing usecounting and generally being
> totally incompatible with the common clock framework.
> 
> This patch adds support for clkctrl clocks for addressing the above
> issues. These support the modulemode handling, which will replace the
> direct hwmod clkctrl linkage. Any optional clocks are also supported,
> gate, mux and divider.

Acked-by: Tony Lindgren <tony@atomide.com>
