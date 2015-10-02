From: horms@verge.net.au (Simon Horman)
Date: Fri, 2 Oct 2015 11:28:39 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.4
In-Reply-To: <20150924050843.GA3822@verge.net.au>
References: <cover.1442536920.git.horms+renesas@verge.net.au>
 <CAMuHMdX41ggvKAKrp3s++UMYidhXuASoMP3xzdtnxjoL=0jpSA@mail.gmail.com>
 <1484890.bItsbzvneZ@wuerfel>
 <CAMuHMdX_kgj4c4J4rZUySfJmcV0t2xUBizhp102Xx-k1yn2jQQ@mail.gmail.com>
 <20150918081935.GA20840@verge.net.au>
 <20150924050843.GA3822@verge.net.au>
Message-ID: <20151002022838.GA15481@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Sep 24, 2015 at 02:08:46PM +0900, Simon Horman wrote:
> Hi Arnd,
> 
> On Fri, Sep 18, 2015 at 05:19:36PM +0900, Simon Horman wrote:
> > On Fri, Sep 18, 2015 at 09:29:58AM +0200, Geert Uytterhoeven wrote:
> > > Hi Arnd,
> > > 
> > > On Fri, Sep 18, 2015 at 9:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Friday 18 September 2015 09:16:31 Geert Uytterhoeven wrote:
> > > >> On Fri, Sep 18, 2015 at 2:47 AM, Simon Horman
> > > >> <horms+renesas@verge.net.au> wrote:
> > > >> > Renesas ARM Based SoC DT Updates for v4.4
> > > >> >
> > > >> > * Add missing CPG/MSTP Clock Domain for sound on r8a779[01] SoCs
> > > >>
> > > >> >       ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain for sound
> > > >> >       ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain for sound
> > > >>
> > > >> These two should actually go in in v4.3, as they're bugfixes for commits that
> > > >> are in v4.3-rc1. That can be done in parallel, though.
> > > >>
> > > >> Sound will stop working in mainline as soon as commit cbc41d0a761bffb3
> > > >> ("drivers: sh: Disable PM runtime for multi-platform ARM with genpd") in
> > > >> sh-drivers-for-v4.3 enters mainline.
> > > >
> > > > The commits are on the top of the branch, so we could just remove them
> > > > here and apply them to the fixes branch if you like.
> > > 
> > > That sounds fine to me, thanks!
> > > 
> > > Simon, is that OK for you?
> > 
> > Yes, perfectly fine.
> 
> I am wondering if you need anything from me at this point.

In the interest of moving things forwards I am:

* Withdrawing this pull request
* Preparing a pull request with only the fixes

I will also prepare an updated, v2, version of this pull request
without the fixes and with some new patches I have queued-up in
the mean time.
