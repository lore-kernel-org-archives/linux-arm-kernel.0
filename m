From: horms@verge.net.au (Simon Horman)
Date: Fri, 18 Sep 2015 16:36:52 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.4
In-Reply-To: <CAMuHMdX41ggvKAKrp3s++UMYidhXuASoMP3xzdtnxjoL=0jpSA@mail.gmail.com>
References: <cover.1442536920.git.horms+renesas@verge.net.au>
 <CAMuHMdX41ggvKAKrp3s++UMYidhXuASoMP3xzdtnxjoL=0jpSA@mail.gmail.com>
Message-ID: <20150918073651.GB28224@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 09:16:31AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Sep 18, 2015 at 2:47 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Renesas ARM Based SoC DT Updates for v4.4
> >
> > * Add missing CPG/MSTP Clock Domain for sound on r8a779[01] SoCs
> 
> >       ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain for sound
> >       ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain for sound
> 
> These two should actually go in in v4.3, as they're bugfixes for commits that
> are in v4.3-rc1. That can be done in parallel, though.

Thanks, I'll resubmit those patches as fixes and revise
this pull request accordingly.

> Sound will stop working in mainline as soon as commit cbc41d0a761bffb3
> ("drivers: sh: Disable PM runtime for multi-platform ARM with genpd") in
> sh-drivers-for-v4.3 enters mainline.

I sent a pull-request for that yesterday, so presumably that will be soon.
