From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Mar 2012 21:09:00 +0000
Subject: [PATCH] ARM: tegra: update main repo and add patchwork
In-Reply-To: <1332092651-25346-1-git-send-email-olof@lixom.net>
References: <1332092651-25346-1-git-send-email-olof@lixom.net>
Message-ID: <201203192109.00862.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 18 March 2012, Olof Johansson wrote:
> Stephen is taking over the main tegra repo, so change the entry to point at his tree on kernel.org
> 
> Also, document the patchwork URL.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> 
> 
> Arnd, I applied the previous Tegra maintainer patch to next/maintainers
> directly, so this should just go on top of there.

Hi Olof,

I've applied all four trivial pull requests now, the dt ones ended up on the next/dt2
branch and will be sent together with the other late dt patches, which meant that
I also had to pull in the previous tegra/dt patches into both next/dt2 in addition
to next/dt.

	Arnd
