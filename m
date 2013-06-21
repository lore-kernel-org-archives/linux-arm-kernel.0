From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Jun 2013 00:32:50 -0700
Subject: [PATCHv2 06/11] CLK: omap: move part of the machine specific
 clock header contents to driver
In-Reply-To: <1371647942-4811-7-git-send-email-t-kristo@ti.com>
References: <1371647942-4811-1-git-send-email-t-kristo@ti.com>
 <1371647942-4811-7-git-send-email-t-kristo@ti.com>
Message-ID: <20130621073250.GO5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [130619 06:25]:
> Some of the clock.h contents are needed by the new OMAP clock driver,
> including dpll_data and clk_hw_omap. Thus, move these to the generic
> omap header file which can be accessed by the driver.

Do you mean "are only needed by the new OMAP clock driver"?

Otherwise it sounds like this will break things for other
omaps that don't yet have clocks configured in DT..

Regards,

Tony
