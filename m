From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Mar 2010 16:06:51 -0800
Subject: [PATCH 18/19] omap: Add DSI regulator supply to OMAP3EVM board
	file
In-Reply-To: <20100311235958.GX2900@atomide.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
	<20100311235958.GX2900@atomide.com>
Message-ID: <20100312000651.GZ2900@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100311 15:55]:
> From 9c7ceeb2621349f180be4779d954352bcc8df9cd Mon Sep 17 00:00:00 2001
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> Date: Thu, 11 Mar 2010 08:55:17 +0000
> Subject: [PATCH] omap: Add DSI regulator supply to OMAP3EVM board file
> 
> With recent changes happened in OMAP2/3 DSS library for regulator interface, it
> is required to define DSI regulator supply, without this DSS (in turn Fbdev)
> fails to get regulator.

Oops, had to manually send the last two messages.. This is already
at 17/18, so please ignore.

Regards,

Tony
