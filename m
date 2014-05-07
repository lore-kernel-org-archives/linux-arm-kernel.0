From: horms@verge.net.au (Simon Horman)
Date: Wed, 7 May 2014 16:54:21 +1200
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Updates for v3.16
In-Reply-To: <20140506014623.GB4701@quad.lixom.net>
References: <cover.1398737681.git.horms+renesas@verge.net.au>
 <20140506014623.GB4701@quad.lixom.net>
Message-ID: <20140507045421.GB14157@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 06:46:23PM -0700, Olof Johansson wrote:
> On Tue, Apr 29, 2014 at 11:15:38AM +0900, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these second round of Renesas ARM based SoC updates for v3.16.
> > 
> > This pull request is based on the previous round of
> > such requests, tagged as renesas-soc-for-v3.16,
> > which I have already sent a pull-request for.
> > 
> > 
> > The following changes since commit e35db38d66d1e4007cfc1bb90a05e11b4aaee2a8:
> > 
> >   ARM: shmobile: r8a7778/bockw: Move "select RENESAS_INTC_IRQPIN" under SoC (2014-04-14 11:28:43 +0900)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.16
> > 
> > for you to fetch changes up to ab496b9d259e754f5d646219e4f032b274b9fffe:
> > 
> >   ARM: shmobile: Ignore callbacks for subsys generic_pm_domain_data (2014-04-25 10:01:43 +0900)
> 
> Merged into next/soc. It's OK to keep it here, but pure removals like
> these usually go in the cleanup branch. It can be tricky when there's
> dependencies on new code though, which you might have had in this
> case. Either way, no need to respin, etc.

Thanks, noted.

In this case I think that there aren't any awkward dependencies.
