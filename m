From: horms@verge.net.au (Simon Horman)
Date: Sat, 4 Jan 2014 08:42:38 +0900
Subject: [GIT PULL 00/21] Third Round of Renesas ARM Based SoC DT Updates
 for v3.14
In-Reply-To: <20140102184939.GE8684@quad.lixom.net>
References: <cover.1387893834.git.horms+renesas@verge.net.au>
 <20140102184939.GE8684@quad.lixom.net>
Message-ID: <20140103234238.GA5150@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 10:49:39AM -0800, Olof Johansson wrote:
> On Tue, Dec 24, 2013 at 11:19:23PM +0900, Simon Horman wrote:
> > Hi Kevin, Hi Olof, Hi Arnd,
> > 
> > please consider this third round of Renesas ARM based SoC DT updates for v3.14.
> > 
> > This is based on a merge of:
> > 
> > * The second round of Renesas ARM based SoC DT updates for v3.14,
> >   tagged as renesas-dt2-for-v3.14, which I have previously sent a
> >   pull-request for.
> > 
> > * The second round of Renesas ARM based SoC updates for v3.14,
> >   tagged as renesas-soc2-for-v3.14, which I have previously sent a
> >   pull-request for.
> > 
> > * The clk-next-shmobile branch of Mike Turquette's tree

git://git.linaro.org/people/mike.turquette/linux.git clk-next-shmobile

> > 
> > * The clockevents/for-Simon-3.13-rc2 branch of Daniel Lezcano's tree

git://git.linaro.org/people/daniel.lezcano/linux.git clockevents/for-Simon-3.13-rc2

> > * The pinctl/for-next branch of Linus Walleij's tree

git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git pinctl/for-next

> > 
> > * v3.13-rc3
> 
> Ah, here's the missing clk branch that caused earlier merges not to build.

Yes, sorry about that.

> Please provide actual URLs for the external branches since we want to
> track them. I can't reverse-engineer them since you use remotes instead
> of the URL when you merged in, unfortunately.
> 
> (No need to redo the pull request, just give me the URLs, please.

Sorry about that. Is the information I have added above sufficient?

> > The reason for these merges is to provide dependencies for
> > the clock updates for the r8a7791 (R-Car M2) based Koelsch and r8a7790
> > (R-Car H2) based Lager boards.
> > 
> > 
> > The following changes since commit b652896b02df3dfde3a68957cce01f2aa4585842:
> > 
> >   ARM: shmobile: r8a7791: Add SSI clocks in device tree (2013-12-24 23:01:13 +0900)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt3-for-v3.14
> 
> Pulled, thanks.
> 
> 
> -Olof
> 
