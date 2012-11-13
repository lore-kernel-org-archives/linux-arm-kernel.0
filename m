From: davem@davemloft.net (David Miller)
Date: Tue, 13 Nov 2012 14:44:06 -0500 (EST)
Subject: [PATCH] wanrouter: Remove it and the drivers that depend on it
In-Reply-To: <67fe0c5701a8c7cfe06b178cf04b1c5c06592714.1352548454.git.joe@perches.com>
References: <67fe0c5701a8c7cfe06b178cf04b1c5c06592714.1352548454.git.joe@perches.com>
Message-ID: <20121113.144406.1610017702502358739.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joe Perches <joe@perches.com>
Date: Sat, 10 Nov 2012 06:20:55 -0800

> Remove wanrouter as it's obsolete and has not been updated
> by sangoma since 2.4.3 or so and it's not used anymore.
> 
> Remove obsolete cyclomx drivers.
> Update defconfig files that enable wanrouter.
> Update files that include now deleted wanrouter bits.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

I'm fine with this change, except the arch defconfig bits.

We've been leaving those alone, and letting the arch maintainers
do the updates themselves periodically.

Please resubmit this with those parts removed.

Thanks.
