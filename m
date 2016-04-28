From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Apr 2016 22:37:53 +0200
Subject: [GIT PULL 1/3] ARM: dts: exynos: Secound round of DTS for v4.7
In-Reply-To: <20160428190428.GA10520@kozik-lap>
References: <1461748256-4394-1-git-send-email-k.kozlowski@samsung.com>
 <1956683.Gv388axJqA@wuerfel> <20160428190428.GA10520@kozik-lap>
Message-ID: <3806573.U95ZyAj1xD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 April 2016 21:04:28 Krzysztof Kozlowski wrote:
> On Thu, Apr 28, 2016 at 04:06:54PM +0200, Arnd Bergmann wrote:
> > On Wednesday 27 April 2016 11:10:54 Krzysztof Kozlowski wrote:
> > >   kernel.org:/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.7-2
> > > 
> > 
> > Pulled into next/dt after I figured out that the URL was wrong.
> > 
> > Please check your git configuration to make sure you send an address
> > I can pull from.
> 
> Ah, indeed, sorry for that. I still did not automate entirely this process
> so apparently I am doing simple mistakes. I'll be more carefull next
> time.

Ok. The trick is to have a separate 'url' and 'pushurl' entry in your
git config, like

[remote "origin"]
        url = git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
        pushurl = git+ssh://gitolite at ra.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git

That way, 'git request-pull' will pick the first one, but 'git push' will
use the second.

	Arnd
