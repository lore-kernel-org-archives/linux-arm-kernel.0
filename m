From: olof@lixom.net (Olof Johansson)
Date: Fri, 21 Feb 2014 14:25:44 -0800
Subject: [GIT PULL 00/12] Second Round of Renesas ARM Based SoC Updates
 for v3.15
In-Reply-To: <20140220094324.GR19089@quad.lixom.net>
References: <cover.1392277789.git.horms+renesas@verge.net.au>
 <20140220094324.GR19089@quad.lixom.net>
Message-ID: <20140221222544.GA13233@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 01:43:24AM -0800, Olof Johansson wrote:
> On Thu, Feb 13, 2014 at 05:04:56PM +0900, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > please consider this second round of Renesas ARM Based SoC updates for v3.15.
> > 
> > This pull-request is based on the first round of such changes,
> > tagged as renesas-soc-for-v3.15, which I have previously sent a
> > pull-request for.
> > 
> > 
> > The following changes since commit 012a7069b5a10a0851584d71a1facdc40a972319:
> > 
> >   ARM: shmobile: r8a7790: Add PCI USB host clock support (2014-02-04 10:25:03 +0900)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.15
> 
> Hi,
> 
> I'm stopping my merges for the night here, so I haven't merged this but I'll
> likely do it tomorrow. I did have comments on one of the patches though (that
> adds a new include/mach file that's not really needed). Fixing that can be done
> incrementally though, especially if you have downstream users of this branch.

Simon,

I think it'd fit our workflow better if you kept all the clock changes in
a topic branch this release, instead of mingling them with the SoC code.
There is enough of them that it's not just a silly short branch, and there's
little overlap with the rest of the soc code changes you have (i.e. it makes
more sense for us to merge in with a drivers branch instead of keeping it all
with soc).

Would you mind respinning and sorting that out to a separate topic? Since
I've already merged the first soc branch (but treated it like a clock
branch), feel free to keep that as a base for the new clock branch
(but not for the new soc branch, ideally).


-Olof
