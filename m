From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Mar 2012 22:14:06 +0000
Subject: [PATCH 0/4] ARM: kirkwood: fdt: convert kirkwood init funcs to fdt
In-Reply-To: <20120301212353.GC11986@titan.lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <201203012028.04773.arnd@arndb.de>
 <20120301212353.GC11986@titan.lakedaemon.net>
Message-ID: <201203012214.07019.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, Jason wrote:
> On Thu, Mar 01, 2012 at 08:28:04PM +0000, Arnd Bergmann wrote:
> > On Thursday 01 March 2012, Jason wrote:
> > > Thanks for the feedback.  I'll redo this series and resubmit.  Did you
> > > catch my patch from yesterday?
> > > 
> > > [PATCH v3] ARM: kirkwood: covert orion-spi to fdt. [1]
> > 
> > Yes, I saw that. It looks good and I was just waiting if other people
> > have comments on it. Maybe you can put it into the same git tree as
> > these ones when they are ready and you send a pull request.
> 
> Okay, I have a local branch, 'dreamplug_dt' based at v3.3-rc3.  It
> includes the two patches you've already merged into your tree:
> 
> c9780e7 ARM: kirkwood: add dreamplug (fdt) support.
> dbc3c26 ARM: kirkwood: convert uart0 to devicetree.
> 
> Plus the spi/flash/partitions, and the most recent series.
> 
> Can I just do:
> 
> git push linux-kirkwood dreamplug_dt:kirkwood_dt
> 
> Then, issue a pull request for
> 
> git://git.infradead.org/users/jcooper/linux-kirkwood.git kirkwood_dt
> 
> and reference the first uncommitted patch?

I have other commit IDs for the two patches that I took from your
emails, so you should rebase the other patches on top of the
version that I have in the arm-soc/kirkwood/board branch, otherwise
we end up with duplicate commits my tree when I pull them again.

> Most of the googlings for 'pull request' yield github's "click the
> button", yuck.
> 
> Also, is there an equivalent to 'git format-patch/send-email' for pull
> requests?  The pull requests I've looked at seem awfully consistent in
> formatting.

It's "git request-pull".

	Arnd
