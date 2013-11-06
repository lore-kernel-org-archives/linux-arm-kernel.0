From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 6 Nov 2013 06:42:44 -0500
Subject: [PATCH v3 25/28] ARM: mvebu: Add support for NAND controller
 in Armada 370/XP
In-Reply-To: <20131106092435.5f95aa55@skate>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383656135-8627-26-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131105132905.GJ3060@titan.lakedaemon.net>
 <20131105135145.GA2676@localhost>
 <20131105151531.GK3060@titan.lakedaemon.net>
 <20131106092435.5f95aa55@skate>
Message-ID: <20131106114244.GC8308@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

Adding Grant and Mark to the Cc to make sure they don't have buyer's
remorse ;-)

On Wed, Nov 06, 2013 at 09:24:35AM +0100, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Tue, 5 Nov 2013 10:15:31 -0500, Jason Cooper wrote:
> 
> > > And I'd rather do that in a separate patch, to avoid cluttering the poor
> > > devicetree people with an unrelated 28-piece patch :-)
> > 
> > No (really), according to Grant and Mark during the closing session, I
> > asked this specific question.  They _do_ want the entire series so they
> > can refer to the corresponding code changes if necessary.  As I stated
> > above, we can make their job easier by making the binding a separate
> > patch that is clearly marked as such.
> 
> Interesting, because I had understood exactly the opposite from the
> discussions at the ARM kernel summit. But maybe the DT folks changed
> their mind between the ARM kernel summit and the closing session of the
> kernel summit :-)

Yes, that's why I asked the question.  Mark Rutland said he wanted to
see the code changes when he was reviewing a binding.  Which is indeed
the opposite of what we had arrived at during the ARM mini-summit.

So I asked Grant (last question of the Q&A) what he wanted us to tell
the contributors.  He said (bad paraphrasing here) "I have better
filters now for finding the binding changes, so send the whole series"

As him and Mark aren't the only reviewers, I took the extra step of
saying send the DT bindings as a separate patch with it clearly
identified in the subject line...

thx,

Jason.
