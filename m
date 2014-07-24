From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jul 2014 20:08:17 -0400
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.17 (round 3)
In-Reply-To: <CAOesGMj1euJo-NPO-Ah18enuJc12u9ndaYo=9dM37pX_yX-wUw@mail.gmail.com>
References: <20140722205706.GA23220@titan.lakedaemon.net>
 <201407232231.41787.arnd@arndb.de>
 <20140723234130.GM23220@titan.lakedaemon.net>
 <CAOesGMj1euJo-NPO-Ah18enuJc12u9ndaYo=9dM37pX_yX-wUw@mail.gmail.com>
Message-ID: <20140724000817.GP23220@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 04:45:15PM -0700, Olof Johansson wrote:
> On Wed, Jul 23, 2014 at 4:41 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > On Wed, Jul 23, 2014 at 10:31:41PM +0200, Arnd Bergmann wrote:
> >> On Tuesday 22 July 2014, Jason Cooper wrote:
...
> >> > As usual (do I need to type this each time any more? :) ), this is an
> >> > incremental pull request from tags/mvebu-soc-3.17-2 up to
> >> > tags/mvebu-soc-3.17-3 on the mvebu/soc branch.
> >>
> >> It certainly helps me to have this information, but you can write it
> >> more briefly, e.g. "based on tags/mvebu-soc-3.17-2".
> >
> > Ahhhh....  Much more succinct.  Thank you.  On a side note, I wonder
> > what it would take to get 'git request-pull' smart enough to add that
> > information when handed a tag?
> >
> >> > The following changes since commit ba364fc752daeded072a5ef31e43b84cb1f9e5fd:
> >> >
> >> >   ARM: Kirkwood: Remove mach-kirkwood (2014-07-13 22:13:39 +0000)
> >
> > eg:
> >
> >   ARM: Kirkwood: Remove mach-kirkwood (tags/mvebu-soc-3.17-2)
> 
> That only maps to the tag in your tree, which might or might not map
> directly to something that we know or care about. We do tend to keep
> naming similar, but not always identical. For example, the branch for
> that tag would be mvebu/soc2 in our tree.

Right, the goal was to automate 'based on tags/mvebu-soc-3.17-2' which
lets you guys know it's an incremental pull request.

> > Is the date of the base commit useful in any way in the pull request?
> 
> I find the SHA to be useful, I will sometimes run "git branch
> --contains ba3ec57<...>" to see where the base is merged already. The
> date, for me, less so.

Ok, good to know.

thx,

Jason.
