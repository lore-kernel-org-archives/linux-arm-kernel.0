From: jason@lakedaemon.net (Jason)
Date: Thu, 1 Mar 2012 16:23:53 -0500
Subject: [PATCH 0/4] ARM: kirkwood: fdt: convert kirkwood init funcs to fdt
In-Reply-To: <201203012028.04773.arnd@arndb.de>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <201203011950.51210.arnd@arndb.de>
 <20120301200136.GA11986@titan.lakedaemon.net>
 <201203012028.04773.arnd@arndb.de>
Message-ID: <20120301212353.GC11986@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2012 at 08:28:04PM +0000, Arnd Bergmann wrote:
> On Thursday 01 March 2012, Jason wrote:
> > Thanks for the feedback.  I'll redo this series and resubmit.  Did you
> > catch my patch from yesterday?
> > 
> > [PATCH v3] ARM: kirkwood: covert orion-spi to fdt. [1]
> 
> Yes, I saw that. It looks good and I was just waiting if other people
> have comments on it. Maybe you can put it into the same git tree as
> these ones when they are ready and you send a pull request.

Okay, I have a local branch, 'dreamplug_dt' based at v3.3-rc3.  It
includes the two patches you've already merged into your tree:

c9780e7 ARM: kirkwood: add dreamplug (fdt) support.
dbc3c26 ARM: kirkwood: convert uart0 to devicetree.

Plus the spi/flash/partitions, and the most recent series.

Can I just do:

git push linux-kirkwood dreamplug_dt:kirkwood_dt

Then, issue a pull request for

git://git.infradead.org/users/jcooper/linux-kirkwood.git kirkwood_dt

and reference the first uncommitted patch?

Most of the googlings for 'pull request' yield github's "click the
button", yuck.

Also, is there an equivalent to 'git format-patch/send-email' for pull
requests?  The pull requests I've looked at seem awfully consistent in
formatting.

thx,

Jason.
