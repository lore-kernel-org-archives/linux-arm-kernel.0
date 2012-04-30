From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Apr 2012 17:46:44 +0000
Subject: [GIT PULL] ARM: SPEAr13xx support for 3.5
In-Reply-To: <CAOh2x==Dh5thHoQaQ+eN34oeWsmZ32kMOOQ6nU5kO7Tfcr=PUA@mail.gmail.com>
References: <CAOh2x==Dh5thHoQaQ+eN34oeWsmZ32kMOOQ6nU5kO7Tfcr=PUA@mail.gmail.com>
Message-ID: <201204301746.45004.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 April 2012, viresh kumar wrote:
> Hi Arnd/Olof,
> 
> This is pull request for SPEAr13xx support updates. It had dependency
> on for-v3.5-spear-clk, spear/dt and spear/pinctrl for applying patches, and
> so i created a merge of v3.4-rc5 with spear/dt and pinctrl branches and applied
> for-v3.5-spear-clk patches, before this patchset.
> 
> Also, it has compilation dependencies with:
> - Mike's clk-next branch
> - Russell's: CLKDEV: Add helper routines to allocate and add clkdevs for ...

Ok, I missed the compilation dependencies you mentioned here.  So the branch
you sent me doesn't actually build by itself, which is not good.

I have now merged both as staging branches, which means it will be in linux-next
from now on but can still get rebased in order to work out the dependencies.
We can work out something from here once I understand where the dependencies
are.

	Arnd
