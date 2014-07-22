From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jul 2014 22:57:17 +0200
Subject: [PATCH v8 00/11] ARM: brcmstb: Add Broadcom STB SoC support
In-Reply-To: <20140722204431.GG28323@ld-irv-0074>
References: <1405976886-27807-1-git-send-email-computersforpeace@gmail.com>
 <5675728.WLk3P96IBM@wuerfel> <20140722204431.GG28323@ld-irv-0074>
Message-ID: <5044348.IEPQPrahyu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 July 2014 13:44:31 Brian Norris wrote:
> > For the platform changes in the first patch, I would prefer to have
> > Matt pick up the first patch, but we can also apply it directly into
> > arm-soc if he prefers that.
> 
> That brings up a question related to PATCH 11 in the series (MAINTAINERS
> update); who will be maintaining arch/arm/mach-bcm/*brcmstb*, and how
> will code go upstream? It seems like Matt and Christian are officially
> mach-bcm maintainers, although I don't know if Christian is still
> involved.

You have to solve that question together with Matt. From my perspective
it would be easier if I only have to deal with one person for mach-bcm,
but it's really up to you.

> Also, BCM7xxx shares little in common with the rest of mach-bcm, except
> a company name, so we'd really like at least the 'Maintainer' entries
> for the CC. I was planning on a separate git tree too, although it could
> have conflicts if we touch arch/arm/mach-bcm/{Makefile,Kconfig}.
> 
> So would we send a separate arm-soc pull request for the arm-soc
> targeted changes (and all future development)?

You can definitely have the separate MAINTAINERS entry without necessarily
becoming a maintainer at the same level. I know Matt is very responsive
and can forward your patches to arm-soc if that works for you.

> For the reset of mach-bcm stuff, I'll just send an arm-soc pull request
> soon enough, unless Matt/Arnd/Olof object.

I'll wait for Matt to comment before pulling it, otherwise that sounds
fine.

	Arnd
