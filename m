From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 May 2013 12:45:04 -0700
Subject: [RFC PATCH 0/3] ARM: omap3: add Seagate Wireless Plus board
In-Reply-To: <cover.1368038129.git.jason@lakedaemon.net>
References: <cover.1368038129.git.jason@lakedaemon.net>
Message-ID: <20130508194504.GD32546@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jason Cooper <jason@lakedaemon.net> [130508 12:29]:
> 
> Tony has been helping me out offline with this, and he suggested trying the
> gpmc against Linus' ToT.  Which locks up before it even has a chance to get
> going.  So this series is against v3.9.

You may have better luck with today's mainline treeand the following fix:

http://lkml.org/lkml/2013/5/8/374#

Regards,

Tony
