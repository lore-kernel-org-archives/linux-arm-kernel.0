From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Feb 2014 19:59:00 -0500
Subject: [GIT PULL] ARM: mvebu soc changes for v3.15
In-Reply-To: <20140222003415.GE13233@quad.lixom.net>
References: <20140218163628.GW7862@titan.lakedaemon.net>
 <20140222003415.GE13233@quad.lixom.net>
Message-ID: <20140222005900.GP7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 04:34:15PM -0800, Olof Johansson wrote:
> On Tue, Feb 18, 2014 at 11:36:28AM -0500, Jason Cooper wrote:
> > All,
> > 
> > A small round of changes that have been sitting in -next for a week or
> > so.  Please pull.
> > 
> > thx,
> > 
> > Jason.
> > 
> > 
> > The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> > 
> >   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.15
> > 
> > for you to fetch changes up to 08bb3adfd3adeb4653095e7968b6a46cef940404:
> > 
> >   ARM: mvebu: remove unneeded ->map_io field for Armada 370/XP (2014-02-11 19:33:04 +0000)
> 
> Thanks, merged into next/cleanup.

Heads up:  I'm currently basing mvebu/soc-3xx on top of this work to
avoid keeping track of a tricky modify/rename merge.  Namely, removing
map_io in the above, and the mvebu/soc-3xx branch renames the same file.

As long as you don't mind having a branch depending on next/cleanup, all
should be good.  No action required.

I'd've mentioned it in the pull request, but we just discovered it today
and I did the rebase 5 minutes ago. :)

thx,

Jason.
