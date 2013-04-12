From: horms@verge.net.au (Simon Horman)
Date: Fri, 12 Apr 2013 09:21:37 +0900
Subject: [GIT PULL] Renesas ARM based SoC lager board updates for v3.10
In-Reply-To: <20130411173819.GC373@quad.lixom.net>
References: <1365668326-22518-1-git-send-email-horms+renesas@verge.net.au>
 <20130411173819.GC373@quad.lixom.net>
Message-ID: <20130412002134.GA24461@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 10:38:19AM -0700, Olof Johansson wrote:
> On Thu, Apr 11, 2013 at 05:18:45PM +0900, Simon Horman wrote:
> > Hi Arnd, Hi Olof,
> > 
> > Please note this is based on a merge with renesas-soc-r8a7790-for-v3.10
> > which corresponds to the pull request I sent a few minutes ago:
> > "[GIT PULL] Renesas ARM based r8a7790 SoC update for v3.10".
> > 
> > The following changes since commit ac119ccd80eb914185229c4c4086f3debdd4c764:
> > 
> >   Merge branch 'soc-r8a7790' into boards-lager (2013-04-09 21:40:20 +0900)
> > 
> > are available in the git repository at:
> > 
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-lager-for-v3.10
> > 
> > for you to fetch changes up to 65be2de17aae0fd94e55f7c4a474933cf4607ea2:
> > 
> >   ARM: shmobile: use r8a7790 timer setup code on Lager (2013-04-09 21:40:59 +0900)
> > 
> > ----------------------------------------------------------------
> > Renesas ARM based SoC lager board updates for v3.10
> > 
> > * Use r8a7790 timer setup code to force the
> >   arch timer to be enabled regardless of the bootloader setting
> >   - This is necessary for the lager board to boot
> > 
> > This pull request is based on:
> > git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-boards3-for-v3.10
> > git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-soc-r8a7790-for-v3.10
> > 
> > The merge was made to provide the r8a7790 timer setup code
> 
> Pulled.
> 
> By the way, the dependencies above are probably better described in
> the email than in the tag, since there's a good chance your branches
> will be gone from kernel.org by the time someone reads the changelog;
> i.e. it doesn't really provide useful information for the changelog. It's very
> useful for us though so please continue to provide it.

Thanks. In general the merges refer to tags which I intend to keep around.
But I take your point and I will move the merge information out of the
tag and thus the change log and into the email.
