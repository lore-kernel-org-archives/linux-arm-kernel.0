From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Jan 2011 14:21:27 -0800
Subject: [PATCHv4 2/4] OMAP3: Devkit8000: Fix tps65930 pullup/pulldown
	configuration
In-Reply-To: <1295425166-25540-3-git-send-email-weber@corscience.de>
References: <1295425166-25540-1-git-send-email-weber@corscience.de>
	<1295425166-25540-3-git-send-email-weber@corscience.de>
Message-ID: <20110119222126.GI4957@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thomas Weber <weber@corscience.de> [110119 00:18]:
> From: Daniel Morsing <daniel.morsing@gmail.com>
> 
> gpio7 on the tps65930 is used as an output on the devkit8000 and
> gpio1 is not connected. Remove gpio7 and change gpio1 to pulldown
> 
> Signed-off-by: Daniel Morsing <daniel.morsing@gmail.com>

I'll queue only this fix for now, looks like the other still need
minor changes.

Tony
