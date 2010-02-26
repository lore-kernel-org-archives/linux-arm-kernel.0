From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Fri, 26 Feb 2010 15:53:37 -0800
Subject: LPC32XX architecture files (updated v5)
Message-ID: <1267228430-27193-1-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thanks for reviewing. This is the 5th patchset. Updates
are listed below..

Greatly simplified debug-macro.S (similar to other drivers
	that use debug-8250.S)
Clock driver changes - type fixes to some functions, clock
	tree enabled from top down and disabled from bottom
	up, fixed round clock support, AMBA driver fixes for
	get_clk_rate, AMBA fix to allow a clock rate to be
	set without the clock needing to be enabled, other
	review changes

thanks,
Kevin Wells
NXP Semiconductors
