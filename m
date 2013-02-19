From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Feb 2013 21:52:00 +0000
Subject: [GIT PULL] i.MX defconfig updates
In-Reply-To: <201302192148.19138.arnd@arndb.de>
References: <20130212085916.GT1906@pengutronix.de>
 <201302192148.19138.arnd@arndb.de>
Message-ID: <201302192152.00964.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 February 2013, Arnd Bergmann wrote:
> On Tuesday 12 February 2013, Sascha Hauer wrote:
> > ----------------------------------------------------------------
> > ARM i.MX defconfig updates for v3.9
> > 
> > - enable VPU support in imx_v4_v5_defconfig to get compile coverage
> > - enable netfilter support
> > 
> 
> Pulled into next/soc now. It seems harmless enough that I did not
> bother putting it into a late branch.

Nevermind, I just reverted my pull because Olof had already applied
it to the next/boards branch a week ago. I did not receive a reply
to the pull request, so I assumed he accidentally ignored the pull
request.

	Arnd
