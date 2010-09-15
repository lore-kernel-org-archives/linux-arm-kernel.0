From: tony@atomide.com (Tony Lindgren)
Date: Wed, 15 Sep 2010 09:34:03 -0700
Subject: [PATCH v5 0/7] native wl1271 support on ZOOM
In-Reply-To: <20100915132149.GA6997@tuxdriver.com>
References: <1283376410-9999-1-git-send-email-ohad@wizery.com>
	<AANLkTikedoL3HjohQfq2qa0TU5yMJR5p1GqyQJtQGrdb@mail.gmail.com>
	<AANLkTingdk=9Fbp9uKf6rGyAtR+b8KV4vFmYRfakkwBs@mail.gmail.com>
	<20100915132149.GA6997@tuxdriver.com>
Message-ID: <20100915163403.GT8647@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* John W. Linville <linville@tuxdriver.com> [100915 06:21]:
> On Wed, Sep 15, 2010 at 01:08:18PM +0200, Vitaly Wool wrote:
> > On Wed, Sep 15, 2010 at 11:21 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > > On Wed, Sep 1, 2010 at 11:26 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > >> This patchset adds wl1271 support on ZOOM2/3 boards.
> > >
> > > Tony, John, let me please suggest merging this through the wireless tree.
> > >
> > > wl1271 is a moving target - it keeps changing in the wireless tree and
> > > merging this patchset there will allow wl1271 developers to have
> > > everything in a single tree (and prevent merge conflicts in
> > > linux-next).
> > 
> > Thanks Ohad, that's what I was about to suggest as well. :)
> 
> OK, that is fine with me if the omap folks agree?

Yes sounds good to me, I think there's still at least some platform_data
conversation going on though.

Tony
