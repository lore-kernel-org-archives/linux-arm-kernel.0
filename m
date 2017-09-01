From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Sep 2017 13:30:36 -0700
Subject: [PATCH 1/2] clk: sunxi-ng: Provide a default reset hook
In-Reply-To: <CAPDyKFqw7PNs_GQXmbJx8doo-tGW6PsKSffJhzVgU3cX3-wvsg@mail.gmail.com>
References: <20170825094953.3247-1-maxime.ripard@free-electrons.com>
 <CAPDyKFonXp4Uqi=DLxKf=1ecOx-2E5mUkEXqnqJPE-J57xXQcw@mail.gmail.com>
 <20170830123624.vurdnh6bojbtrjal@flea.lan>
 <CAPDyKFqw7PNs_GQXmbJx8doo-tGW6PsKSffJhzVgU3cX3-wvsg@mail.gmail.com>
Message-ID: <20170901203036.GA21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30, Ulf Hansson wrote:
> On 30 August 2017 at 14:36, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi Ulf,
> >
> > On Wed, Aug 30, 2017 at 02:29:24PM +0200, Ulf Hansson wrote:
> >> On 25 August 2017 at 11:49, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > The reset hook was left implemented. Provide a dumb implementation so that
> >> > client drivers can depend on it.
> >> >
> >> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >>
> >> Do you want me to pick this up via my mmc tree? If so, is that okay by
> >> the clock maintainers?
> >
> > I also happen to be the maintainer of that part of the kernel
> > (reporting to Mike and Stephen of course). We don't have anything
> > touching that file in next, so unless they feel like it should go
> > through their tree, it would be easier to keep the two changes
> > together and merge them through your tree.
> 
> Alright, I have picked it up for next!
> 

Thanks!

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

if that helps.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
