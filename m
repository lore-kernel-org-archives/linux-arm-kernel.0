From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 2 Sep 2013 13:22:43 -0400
Subject: [PULL REQUEST] big-endian updates for ARM
In-Reply-To: <20130902135126.1a297f99@skate>
References: <52247567.8060504@codethink.co.uk> <20130902135126.1a297f99@skate>
Message-ID: <20130902172243.GC19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 02, 2013 at 01:51:26PM +0200, Thomas Petazzoni wrote:
> Dear Ben Dooks,
> 
> On Mon, 02 Sep 2013 12:24:23 +0100, Ben Dooks wrote:
> > With the last ack added, the following series is ready to be pulled.
> > 
> > The following changes since commit fa8218def1b1a16f0a410e2c1c767b4738cc81fa:
> > 
> >    Merge tag 'regmap-v3.11-rc7' of 
> > git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap (2013-08-27 
> > 10:10:30 -0700)
> > 
> > are available in the git repository at:
> > 
> > 
> >    git://git.baserock.org/delta/linux.git baserock/311-rc7/be/core-v3
> > 
> > for you to fetch changes up to 5217543fe4605fa91065acf5141d88949cd3da1e:
> > 
> >    ARM: signal: sigreturn_codes should be endian neutral to work in BE8 
> > (2013-09-02 11:53:53 +0100)
> 
> Successfully boot tested in LE and BE modes on Armada XP hardware:
> 
> Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Jason, Greg or Andrew, can you give your formal Acked-by as mach-mvebu
> maintainers for "mvebu: support running big-endian" in this series?

No problem.

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
