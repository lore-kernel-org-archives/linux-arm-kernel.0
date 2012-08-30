From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Aug 2012 11:55:56 -0700
Subject: [PATCH 0/9] ARM: OMAP: cleanup plat/board.h file
In-Reply-To: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
References: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <20120830185556.GT1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [120828 16:19]:
> This patch series cleans up the plat/board.h and related files.

Great, thanks for doing this! Nice that we can finally remove
all of that. I've also tested that 770 boots after this, so
looks like we've already fixed up whatever it was depending on.

I'll be applying this into the cleanup branch as soon as I'll
have an immutable commit for Arnd's treewide changes to move
the obvious things into include/linux/platform_data.

Regards,

Tony
