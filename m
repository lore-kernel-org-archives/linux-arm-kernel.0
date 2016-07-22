From: david@fromorbit.com (Dave Chinner)
Date: Fri, 22 Jul 2016 21:58:34 +1000
Subject: next-20160722 build: 1 failures 5 warnings (next-20160722)
In-Reply-To: <20160722103829.GY6509@sirena.org.uk>
References: <E1bQXSf-0008Uu-Ej@optimist> <20160722103829.GY6509@sirena.org.uk>
Message-ID: <20160722115834.GR16044@dastard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2016 at 11:38:29AM +0100, Mark Brown wrote:
> On Fri, Jul 22, 2016 at 11:13:41AM +0100, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build an ARM allmodconfig due to:
> 
> > 	arm-allmodconfig
> > ERROR: "dax_do_io" [fs/xfs/xfs.ko] undefined!

Already fixed.

https://git.kernel.org/cgit/linux/kernel/git/dgc/linux-xfs.git/commit/?h=for-next&id=f021bd071f06b545926b1031348873b05442139f

-- 
Dave Chinner
david at fromorbit.com
