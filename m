From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Mar 2017 10:57:01 -0800
Subject: clk: ti: clkctrl clock support
In-Reply-To: <1486992157-10673-1-git-send-email-t-kristo@ti.com>
References: <1486992157-10673-1-git-send-email-t-kristo@ti.com>
Message-ID: <20170302185700.GT20572@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [170213 05:24]:
> Hi,
> 
> This series is a derivative of the hwmod clock support framework
> (https://www.spinics.net/lists/arm-kernel/msg536742.html.) This
> adds support for clkctrl main and optional clocks, which can be
> linked initially with hwmod framework, and later with the
> interconnect driver functionality. The implementation is based
> on the DT bindings patch from Tony:
> https://patchwork.kernel.org/patch/9533605/
> 
> This series also depends on the TI clock driver cleanup series
> posted here: https://www.spinics.net/lists/arm-kernel/msg562362.html
> 
> OMAP4 used as a reference platform for the work, patches 4-6 contain
> SoC specific patches, out of which 5-6 should not be merged; these
> are only provided as a reference and for testing purposes and are
> incomplete. Rest of the data can be provided once the code is
> approved / merged.

Looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
