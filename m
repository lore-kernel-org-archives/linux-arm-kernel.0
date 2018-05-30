From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 30 May 2018 13:36:59 +0930
Subject: Status of aspeed-bmc-opp-firestone (IBM S822LC)
In-Reply-To: <287c6a85-65ba-5782-e532-d17d517614f5@molgen.mpg.de>
References: <287c6a85-65ba-5782-e532-d17d517614f5@molgen.mpg.de>
Message-ID: <1527653219.1600524.1389969792.6D07B793@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Wed, 30 May 2018, at 00:23, Paul Menzel wrote:
> Dear Joel, dear Linux folks,
> 
> 
> We have an IBM S822LC system (Firestone(?)). Building of OpenBMC 
> currently fails, as the not everything was ported from dev-4.10 to 
> dev-4.13 [1], and therefore a file cannot be found.
> 
> Looking at upstream Linux, there are BMCs for Power 8 systems, like 
> Palmetto, included.
> 
> ```
> $ ls arch/arm/boot/dts/aspeed-bmc-opp-*
> arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
> arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
> ```
> 
> Does somebody know, why Firestone was not upstreamed? Is somebody 
> working on upstreaming it? If not, do you have scripts to port such 
> work? Manually cherry-picking stuff in this case is hard, as there are a 
> lot of conflicts.

Firestone was never really maintained. We hacked around with it for a bit, but nothing concrete really came of it. As far as I'm aware, no-one is working on upstreaming it.

Also, I don't think there were any scripts used in the process, so it's going to be some drudge work to get things running.

Sorry that I don't have a more positive answer. Maybe someone else knows better.

Cheers,

Andrew
