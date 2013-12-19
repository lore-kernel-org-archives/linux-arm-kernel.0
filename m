From: tony@atomide.com (Tony Lindgren)
Date: Thu, 19 Dec 2013 10:26:20 -0800
Subject: [PATCHv11 07/49] clk: divider: add support for low level ops
In-Reply-To: <1387452260-23276-8-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
 <1387452260-23276-8-git-send-email-t-kristo@ti.com>
Message-ID: <20131219182620.GQ27438@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [131219 03:26]:
> Divider clock can now be registered to use low level register access ops.
> Preferred initialization method is via clock description.

This seems to make omap2 not boot for me. No output whatsoever even with
DEBUG_LL and earlyprintk.

Regards,

Tony
