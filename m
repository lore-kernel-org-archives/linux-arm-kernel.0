From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Oct 2009 09:57:14 -0700
Subject: [PATCH 3b/6] omap: Split vmalloc.h for mach-omap1 and mach-omap2
In-Reply-To: <20091014214920.30227.10280.stgit@kaulin.muru.com>
References: <20091014213748.30227.71513.stgit@kaulin.muru.com>
	<20091014214920.30227.10280.stgit@kaulin.muru.com>
Message-ID: <20091020165714.GC12576@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've added a patch to split vmalloc.h into this series to allow
different VMALLOC_END on omap1 and omap2.

Regards,

Tony
