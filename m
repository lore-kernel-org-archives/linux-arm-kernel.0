From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Mar 2013 15:49:56 +0000
Subject: linux-next: manual merge of the tegra tree with the arm-soc tree
In-Reply-To: <51473179.2030306@wwwdotorg.org>
References: <20130318153140.100bdf364d5614ce31f12eae@canb.auug.org.au>
 <51473179.2030306@wwwdotorg.org>
Message-ID: <201303181549.57080.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 March 2013, Stephen Warren wrote:
> On 03/17/2013 10:31 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the tegra tree got a conflict in 
> > drivers/clocksource/tegra20_timer.c between commit 1d16cfb3aeba 
> > ("clocksource: tegra20: use the device_node pointer passed to
> > init") from the arm-soc tree and commit 6f88fb8af6c6 ("clocksource:
> > tegra: move to of_clk_get") from the tegra tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary (no
> > action is required).
> 
> Thanks. This resolution looks fine.
> 
> Arnd/Olof, do you want me to rebase the Tegra branch onto some arm-soc
> branch to resolve this conflict, or are you happy to simply resolve it
> as below when pulling the Tegra branches into arm-soc for 3.10?

No need to rebase. We can resolve this by merging the clksrc/cleanup
into your branch when we pull it, or you can merge it yourself.

	Arnd
