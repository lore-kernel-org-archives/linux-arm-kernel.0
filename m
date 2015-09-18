From: horms@verge.net.au (Simon Horman)
Date: Fri, 18 Sep 2015 16:37:53 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.4
In-Reply-To: <1484890.bItsbzvneZ@wuerfel>
References: <cover.1442536920.git.horms+renesas@verge.net.au>
 <CAMuHMdX41ggvKAKrp3s++UMYidhXuASoMP3xzdtnxjoL=0jpSA@mail.gmail.com>
 <1484890.bItsbzvneZ@wuerfel>
Message-ID: <20150918073753.GC28224@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 09:21:54AM +0200, Arnd Bergmann wrote:
> On Friday 18 September 2015 09:16:31 Geert Uytterhoeven wrote:
> > 
> > On Fri, Sep 18, 2015 at 2:47 AM, Simon Horman
> > <horms+renesas@verge.net.au> wrote:
> > > Renesas ARM Based SoC DT Updates for v4.4
> > >
> > > * Add missing CPG/MSTP Clock Domain for sound on r8a779[01] SoCs
> > 
> > >       ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain for sound
> > >       ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain for sound
> > 
> > These two should actually go in in v4.3, as they're bugfixes for commits that
> > are in v4.3-rc1. That can be done in parallel, though.
> > 
> > Sound will stop working in mainline as soon as commit cbc41d0a761bffb3
> > ("drivers: sh: Disable PM runtime for multi-platform ARM with genpd") in
> > sh-drivers-for-v4.3 enters mainline.
> > 
> 
> The commits are on the top of the branch, so we could just remove them
> here and apply them to the fixes branch if you like.

Thanks, that would be wonderful.

Would you also like me to resubmit this pull request with the top two
patches removed?
