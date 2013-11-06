From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 6 Nov 2013 12:21:06 -0500
Subject: [PATCH v3 25/28] ARM: mvebu: Add support for NAND controller
 in Armada 370/XP
In-Reply-To: <20131106135654.336e06c3@skate>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383656135-8627-26-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131105132905.GJ3060@titan.lakedaemon.net>
 <20131105135145.GA2676@localhost>
 <20131105151531.GK3060@titan.lakedaemon.net>
 <20131106092435.5f95aa55@skate>
 <20131106114244.GC8308@titan.lakedaemon.net>
 <20131106135654.336e06c3@skate>
Message-ID: <20131106172106.GD8308@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 01:56:54PM +0100, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Wed, 6 Nov 2013 06:42:44 -0500, Jason Cooper wrote:
> 
> > > Interesting, because I had understood exactly the opposite from the
> > > discussions at the ARM kernel summit. But maybe the DT folks changed
> > > their mind between the ARM kernel summit and the closing session of
> > > the kernel summit :-)
> > 
> > Yes, that's why I asked the question.  Mark Rutland said he wanted to
> > see the code changes when he was reviewing a binding.  Which is indeed
> > the opposite of what we had arrived at during the ARM mini-summit.
> > 
> > So I asked Grant (last question of the Q&A) what he wanted us to tell
> > the contributors.  He said (bad paraphrasing here) "I have better
> > filters now for finding the binding changes, so send the whole series"
> > 
> > As him and Mark aren't the only reviewers, I took the extra step of
> > saying send the DT bindings as a separate patch with it clearly
> > identified in the subject line...
> 
> Ok, thanks for the clarification. Those rules seem to be changing from
> one day to the next, not really easy to follow :)
> 
> Is there some .txt file in Documentation/ that explains what the DT
> maintainers expect?

hmmm.  Give me a bit. :)

thx,

Jason.
