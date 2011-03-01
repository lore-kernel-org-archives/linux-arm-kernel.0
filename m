From: tony@atomide.com (Tony Lindgren)
Date: Mon, 28 Feb 2011 17:39:28 -0800
Subject: [PATCH resend] omap: Fix linker error in
	drivers/video/omap/lcd_2430sdp.c
In-Reply-To: <1298905757.9809.135.camel@deskari>
References: <1298193466-29534-1-git-send-email-jhnikula@gmail.com>
	<1298232248-347-1-git-send-email-jhnikula@gmail.com>
	<20110224212644.GN20560@atomide.com>
	<20110228164715.e34a965e.jhnikula@gmail.com>
	<1298905757.9809.135.camel@deskari>
Message-ID: <20110301013928.GL20560@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [110228 07:07]:
> 
> Well, it's a bit ugly, but I'm fine with it. It's for the old omapfb,
> which hopefully nobody uses anymore (right =), and there's no simple way
> to make it modular and neat.

How about let's make mach-omap2 boards all use the new code?
That way the old code can be omap1 only.

Regards,

Tony
