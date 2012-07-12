From: mturquette@ti.com (Mike Turquette)
Date: Wed, 11 Jul 2012 17:11:34 -0700
Subject: [PATCH 3/9] ARM: versatile: Make plat-versatile clock optional
In-Reply-To: <CACRpkdYiW8C298K3uPzfJrq09vs-r90brMT_imgz54KtP4Xqsw@mail.gmail.com>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
 <1342013791-19516-4-git-send-email-pawel.moll@arm.com>
 <CACRpkdYiW8C298K3uPzfJrq09vs-r90brMT_imgz54KtP4Xqsw@mail.gmail.com>
Message-ID: <20120712001134.GG2772@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120711-18:43, Linus Walleij wrote:
> On Wed, Jul 11, 2012 at 3:36 PM, Pawel Moll <pawel.moll@arm.com> wrote:
> 
> > ... in preparation for common clock coming for Integrator
> > and Versatile Express.
> >
> > Based on Linus Walleij's "ARM: integrator: convert to common
> > clock" patch.
> >
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> 
> I think Mike is already queueing my patch, so if you're changing
> anything you should build on top of that and submit it to the
> clk tree.
> 
> Mike, is the Integrator patches making it into your for-next branch?
> 

They are there locally and will be pushed in the next hour.

> The merge window is closing in you know...
> 

Oh I'm well aware.  I ended up rebasing clk-3.6 (sigh) so that it would
be on top v3.5-rc6 and pull in the clk-fixes stuff that way.  But this
way I'm getting all of my ducks in a row for the 3.6 merge window.

Regards,
Mike

> Yours,
> Linus Walleij
