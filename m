From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Nov 2009 15:40:52 -0800
Subject: [PATCH] omap: Fix keymap for zoom2 according to matrix keypad framwork
In-Reply-To: <20091116232820.24892.52305.stgit@localhost>
References: <20091116232435.24892.81547.stgit@localhost>
	<20091116232820.24892.52305.stgit@localhost>
Message-ID: <20091116234052.GV3684@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [091116 15:32]:
> From: vikram pandita <vikram.pandita@ti.com>
> 
> Split zoom2 board file into a base board file and a board-zoom-peripherals.c
> file. That way the same peripherals file can be reused for zoom3 and sdp3630
> in addition to zoom2.
> 
> Also remove unused struct omap_board_config_kernel entry.
> 
> NOTE: Keep the twl4030_madc_platform_data and twl4030_platform_data
> entries in board-zoom2.c to avoid merge conflicts with the pending
> patches in MFD tree. These entries will be removed later as a fix.

<snip>

This patch originally had the following matrix keyboard fix in the series,
but I'll try to send it in as a fix.

Regards,

Tony
