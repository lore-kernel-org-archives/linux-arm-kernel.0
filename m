From: davem@davemloft.net (David Miller)
Date: Wed, 10 Dec 2014 20:41:10 -0500 (EST)
Subject: [PATCH v7 2/3] net: Add Keystone NetCP ethernet driver
In-Reply-To: <5488BB96.9070609@ti.com>
References: <1417556503-22290-3-git-send-email-m-karicheri2@ti.com>
 <20141209.131053.2026868499542642866.davem@davemloft.net>
 <5488BB96.9070609@ti.com>
Message-ID: <20141210.204110.618599360537141819.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>
Date: Wed, 10 Dec 2014 16:31:02 -0500

> Are you referring to the static code analyser sparse that is invoked
> through?

You have to explicitly enable endian checking, it's not on by
default.
