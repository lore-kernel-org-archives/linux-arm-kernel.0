From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 Jan 2015 21:44:16 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Sh73a0 Multiplatform Updates
 for v3.20
In-Reply-To: <1524412.qzMh8qoUQG@wuerfel>
References: <cover.1421371996.git.horms+renesas@verge.net.au>
 <1524412.qzMh8qoUQG@wuerfel>
Message-ID: <20150116124416.GB6285@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 09:38:44AM +0100, Arnd Bergmann wrote:
> On Friday 16 January 2015 11:35:25 Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these Renesas ARM based SoC sh73a0 multiplatform updates for v3.20.
> > 
> > This pull request is based on a merge of:
> > 
> > * Renesas ARM Based SoC Drivers Updates for v3.20,
> >   tagged as renesas-drivers-for-v3.20, which I have also sent
> >   a built request for.
> > 
> > * "Renesas ARM Based SoC sh73a0 CCF Updates for v3.20",
> >   tagged as renesas-sh73a0-ccf-for-v3.20.
> > 
> > It is my understnding that both of those dependencies are required in
> > order to transition to a bootable muliplatform kernel for the kzm9g board.
> 
> Nothing wrong with the pull request, but I have a question for my
> understanding about where you are with multiplatform support. I
> see that after this pull request, only ARCH_SH7372 and ARCH_R8A7778
> are left without multiplatform support. Did I remember correctly
> that you plan to add a common clock driver for ARCH_R8A7778 next,
> move that to multiplatform and then delete all the ARCH_SHMOBILE_LEGACY
> support including ARCH_SH7372?

Hi Arnd,

yes, my understanding is that is (still) the plan.
