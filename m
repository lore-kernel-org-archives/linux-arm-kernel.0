From: horms@verge.net.au (Simon Horman)
Date: Mon, 1 Oct 2012 09:03:29 +0900
Subject: [GIT PULL] Renesas ARM-based SoC: KZM-9A-GT for 3.7
In-Reply-To: <201209282002.28445.arnd@arndb.de>
References: <1346113116-20252-1-git-send-email-horms@verge.net.au>
 <201209282002.28445.arnd@arndb.de>
Message-ID: <20121001000329.GA3888@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 08:02:28PM +0000, Arnd Bergmann wrote:
> On Tuesday 28 August 2012, Simon Horman wrote:
> > ----------------------------------------------------------------
> > Tetsuyuki Kobayashi (1):
> >       ARM: shmobile: kzm9g: enable restarting
> > 
> >  arch/arm/mach-shmobile/board-kzm9g.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> 
> This patch ended up causing a new build warning in combination
> with the io.h changes in Russell's tree.
> 
> I've just applied this patch on top, which is the same thing we
> did to all the other open-coded mmio locations.

Thanks, sorry for missing that.
