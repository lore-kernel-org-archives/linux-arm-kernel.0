From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Mar 2011 11:12:08 -0700
Subject: [RFC PATCH 3/5] OMAP2+:Common CPU DIE ID reading code reads
	wrong registers for OMAP4430
In-Reply-To: <20110312225054.27728.89155.stgit@otae.warmcat.com>
References: <20110312224440.27728.60593.stgit@otae.warmcat.com>
	<20110312225054.27728.89155.stgit@otae.warmcat.com>
Message-ID: <20110314181207.GD7258@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andy Green <andy@warmcat.com> [110312 14:49]:
> This adapts the register offsets used to read the CPU DIE ID registers
> when run on 44XX so they match what is in the OMAP4430 Reference Manual
> page 269

I'll apply only this patch, looks like the rest needs more discussion.

Regards,

Tony
