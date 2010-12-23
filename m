From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 Dec 2010 18:49:33 -0800
Subject: [PATCH 4/6] omap2+: Add struct omap_device_board_data and
	allow omap_device_build initialize pads to mux
In-Reply-To: <20101203004526.31687.72682.stgit@baageli.muru.com>
References: <20101203004040.31687.9476.stgit@baageli.muru.com>
	<20101203004526.31687.72682.stgit@baageli.muru.com>
Message-ID: <20101223024933.GI7771@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [101202 16:35]:
> This way board specific pads can be initialized automatically.
> Note that this does not currently handle the multiple hwmod case.

This one can now be dropped. As Paul pointed out the relationship
to omap_device needs more thinking. So let's populated the hwmod
mux info from each platform device init code for now.

Regards,

Tony
