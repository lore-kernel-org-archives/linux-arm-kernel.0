From: tony@atomide.com (Tony Lindgren)
Date: Fri, 27 Nov 2009 09:44:46 -0800
Subject: [PATCH 6/8] omap: Split i2c platform init for mach-omap1 and
	mach-omap2
In-Reply-To: <20091126001952.1546.21444.stgit@localhost>
References: <20091126001646.1546.34352.stgit@localhost>
	<20091126001952.1546.21444.stgit@localhost>
Message-ID: <20091127174445.GO4348@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [091125 16:19]:
> Otherwise we cannot limit new mux code to mach-omap2.
> The same signal names should eventually work for other
> omaps under mach-omap2.
> 
> Note that these pins don't need to be OMAP_PIN_INPUT_PULLUP,
> just OMAP_PIN_INPUT is enough.

Here's a better version of this patch that actually does the
splitting. The earlier version was a bit of a hack.

Regards,

Tony
