From: tony@atomide.com (Tony Lindgren)
Date: Fri, 30 Jan 2015 17:04:44 -0800
Subject: Clock Regression in next-20150130 caused by cb75a8fcd14e
Message-ID: <20150131010443.GE16250@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Looks like commit cb75a8fcd14e ("clk: Add rate constraints to clocks")
causes a regression on at least omaps where the serial console either
does not show anything, or just prints garbage.

Reverting cb75a8fcd14e makes things work again on next-20150130.

Any ideas?

Regards,

Tony
