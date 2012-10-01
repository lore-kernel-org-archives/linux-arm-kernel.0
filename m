From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Mon, 1 Oct 2012 06:28:44 -0700
Subject: rcu self-detected stall messages on OMAP3, 4 boards
In-Reply-To: <CACRpkdb2f18vwv9qXZkypPxM4UwyeTrDs4+JnpFtYRCzADzFPQ@mail.gmail.com>
References: <alpine.DEB.2.00.1209202244470.32589@utopia.booyaka.com>
 <20120920232114.GO2449@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209211803290.8839@utopia.booyaka.com>
 <20120921185827.GC2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209211900520.8839@utopia.booyaka.com>
 <20120921195717.GD2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209221836070.10663@utopia.booyaka.com>
 <20120922201043.GE2934@linux.vnet.ibm.com>
 <20120922215923.GA13161@linux.vnet.ibm.com>
 <CACRpkdb2f18vwv9qXZkypPxM4UwyeTrDs4+JnpFtYRCzADzFPQ@mail.gmail.com>
Message-ID: <20121001132844.GA2558@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2012 at 10:55:11AM +0200, Linus Walleij wrote:
> On Sat, Sep 22, 2012 at 11:59 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> 
> > rcu: Fix day-one dyntick-idle stall-warning bug
> 
> As mentioned in another thread this solves the same problem for ux500.
> Reported/Tested-by: Linus Walleij <linus.walleij@linaro.org>
> 
> But now it appears that this commit didn't make it into v3.6 so
> it definately needs to be tagged with Cc: stable at kernel.org
> before it gets merged since the stall warnings are kinda scary.

Ingo submitting this to Linus Torvalds earlier today, so we should be
able to send to stable shortly.

							Thanx, Paul
