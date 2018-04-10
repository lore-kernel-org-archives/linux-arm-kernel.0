From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Apr 2018 06:55:16 -0700
Subject: [BUG] Fix drivers/memory O= build
In-Reply-To: <ba6087c5-c69e-1adc-9d9d-0ef5b19fb30e@ti.com>
References: <20180406102519.GN16141@n2100.armlinux.org.uk>
 <20180406164615.GL5700@atomide.com>
 <06568f5b-3e4a-f761-7242-85dcc8aeb6a5@oracle.com>
 <20180406185505.GD10990@n2100.armlinux.org.uk>
 <CAK7LNARbST+-oy-J9B2Q2vSp0nhnn9gqOnT7urZdjQZhSpYB-Q@mail.gmail.com>
 <20180407133817.GE10990@n2100.armlinux.org.uk>
 <ba6087c5-c69e-1adc-9d9d-0ef5b19fb30e@ti.com>
Message-ID: <20180410135516.GT5700@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [180409 16:07]:
> I've inlined the changes below. I will send a proper split up series if it's
> considered acceptable.

Seems fine from my point of view. No need to split the patch, best to
do the fix as a single patch.

We should test build it also with make randconfigs though.

So assuming others are OK with this and it does not introduce
new randconfig build errors:

Acked-by: Tony Lindgren <tony@atomide.com>
