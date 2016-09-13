From: joel@jms.id.au (Joel Stanley)
Date: Tue, 13 Sep 2016 22:14:33 +0930
Subject: [PATCH v3 0/7] aspeed: Integrate pinctrl and gpio drivers
In-Reply-To: <20160830075600.11559-1-andrew@aj.id.au>
References: <20160830075600.11559-1-andrew@aj.id.au>
Message-ID: <CACPK8XdM9V=7tqbu_MYR8=LApCN8s+3dav=E6mck6ixU8PhA9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 5:25 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> Here's v3 of the Aspeed pinctrl and gpio driver integration patches. v2 of the
> integration series can be found at:
>
>   https://lkml.org/lkml/2016/8/19/403

Looks good to me. I commented on the two patches that I don't think we
want to include. If you're happy with that I will send a tree to Arnd.

Arnd, the pinctrl driver is staged for 4.9. We're adding the symbol to
arch/arm/mach-aspeed, so the tree I send will have a dependency on the
pinctrl tree. How do I proceed in this case?

Cheers,

Joel
