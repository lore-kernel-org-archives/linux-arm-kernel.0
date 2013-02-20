From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 20 Feb 2013 10:50:00 -0500
Subject: [GIT PULL 4/4] ARM: mvebu: dt changes with deps for v3.9
In-Reply-To: <201302191723.47157.arnd@arndb.de>
References: <20130216204603.GK23237@titan.lakedaemon.net>
 <201302191723.47157.arnd@arndb.de>
Message-ID: <20130220155000.GR23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 05:23:46PM +0000, Arnd Bergmann wrote:
> On Saturday 16 February 2013, Jason Cooper wrote:
> > The following changes since commit 836dc9e3fbbab0c30aa6e664417225f5c1fb1c39:
> > 
> >   Linux 3.8-rc7 (2013-02-09 08:20:39 +1100)
> > 
> > are available in the git repository at:
> > 
> >   git://git.infradead.org/users/jcooper/linux.git tags/dt_deps_for_v3.9
> > 
> > for you to fetch changes up to 5082d43000dcedd465059957026bfaef0d7f7cfb:
> > 
> >   Dove: Thermal: Add DT node and enable in defconfig (2013-02-16 19:07:16 +0000)
> > 
> > ----------------------------------------------------------------
> > mvebu dt with deps for v3.9
> > 
> > This series of patches have external dependencies on driver maintainer trees.
> > If this pull request doesn't merge easily, let me know and I'll resend for
> > v3.10.
> 
> I only got to looking at this today, and I'd prefer deferring it to 3.10
> now that the merge window is open.

Ok, I'll rebase against v3.9-rc1 and resend without the external
dependencies.

I'll also sit down with Olof this week and see if we can come up with a
sane process (if possible) to keep these sorts of series together.

thx,

Jason.
