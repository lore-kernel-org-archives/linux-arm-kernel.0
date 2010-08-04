From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 Aug 2010 08:35:36 +0300
Subject: [PATCH] Remove ARM default configurations which duplicate
	omap3_defconfig
In-Reply-To: <20100803201921.GA18698@kyllikki.org>
References: <20100803201921.GA18698@kyllikki.org>
Message-ID: <20100804053533.GB6840@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vincent Sanders <vince@simtec.co.uk> [100803 23:23]:
> These configurations are no longer useful as the systems they support
> are covered by the generic omap3_defconfig

Since the defconfigs will stay around at least for a while
in the compacted form..

.. And until we have sorted out how to deal with which drivers
need to be compiled in or as modules for each board, I'd
rather keep these defconfigs around for now.

Can we just disable building these with some blacklist
in Kautobuild?

> Signed-off-by:Vincent Sanders <vince@simtec.co.uk>
> Acked-by:Tony Lindgren <tony@atomide.com>

So Not-yet-acked-by until some Kconfig issues are sorted out :)

Thanks,

Tony
