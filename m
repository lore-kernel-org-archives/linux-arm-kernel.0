From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 17 Apr 2013 20:29:31 +0200
Subject: [PATCHv3 00/10] Use the mvebu PCIe driver on Kirkwood
In-Reply-To: <20130417173810.GD27197@titan.lakedaemon.net>
References: <1365865005-26653-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130417173810.GD27197@titan.lakedaemon.net>
Message-ID: <20130417202931.1caa78ba@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Wed, 17 Apr 2013 13:38:10 -0400, Jason Cooper wrote:

> I applied this series to an experimental branch mvebu-late/pcie.  Please
> check that everything is kosher.  I had to add mvebu/boards as a
> dependency since there is a patch in there alphabetizing kirkwood's
> Kconfig (and thus _defconfig).
> 
> *If* rmk creates a stable branch in time, or drops the patch so we can
> take it, this branch will be rebased to fix that.  Currently, it depends
> on rmk/for-next, which is *not* stable.  This is the only public rmk
> branch that has the needed patch.  :-(
> 
> Assuming the above happens, I'll send two PRs, one for the mvebu-pcie
> stuff, then one for the kirkwood-pcie stuff.
> 
> If the stars align, we're ready.  Otherwise, we have everything set to
> go into arm-soc early for the next round.

Awesome, thanks a lot for all your work! I'm pretty sure Russell will
soon put the patch in a branch somewhere and it will unblock the
situation.

Thanks again,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
