From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 19:15:25 +0000
Subject: [GIT PULL] ARM: tegra: dt2 branch
In-Reply-To: <4FB2812F.1010500@wwwdotorg.org>
References: <1337016017-30537-1-git-send-email-swarren@wwwdotorg.org>
 <201205151143.26008.arnd@arndb.de> <4FB2812F.1010500@wwwdotorg.org>
Message-ID: <201205151915.25543.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Stephen Warren wrote:
> > I think we can't drop it from the driver because of existing powerpc machines
> > providing the property, but it would be ok if you drop it from your .dts
> > files.
> 
> support-8bit is parsed by the Tegra driver only, and only appears in
> tegra-*.dts across all arch/*/boot.dts. I assume you were talking about
> some other property, although I can't tell which from a very quick look
> at arch/powerpc/boot/dts/*.

Right, my mistake.

I guess we could have just removed it right away then.

	Arnd
