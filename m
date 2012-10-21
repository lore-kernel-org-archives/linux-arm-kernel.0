From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 20 Oct 2012 21:52:34 -0400
Subject: [PATCH v3 0/7] mv643xx.c: Add basic device tree support.
In-Reply-To: <1347343411.2603.42.camel@pasglop>
References: <1344350092-24050-1-git-send-email-ian.molton@codethink.co.uk>
 <5028D040.60604@codethink.co.uk> <502D201E.9030304@codethink.co.uk>
 <201209101422.13875.arnd@arndb.de>
 <1347343411.2603.42.camel@pasglop>
Message-ID: <20121021015234.GE25828@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pong.  ;-)

On Tue, Sep 11, 2012 at 04:03:31PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2012-09-10 at 14:22 +0000, Arnd Bergmann wrote:
> > Following up on the old discussion, I talked briefly about this
> > issue with BenH at the kernel summit. The outcome basically is that
> > it's a bit sad to have incompatible bindings, but it's not the end
> > of the world,and it's more important to do it right this time.
> > 
> > Just make sure that you use different values for the 'compatible'
> > strings and then do what you need to get the ARM hardware working.
> > 
> > Ideally, the new binding should be written in a way that powerpc
> > machines can use the same one, but the existing ones all use
> > an version of Open Firmware that is not going to get updated
> > and it's also not too likely that we are going to see new
> > powerpc machines based on this chip.
> 
> Right, mostly these machines where the Pegasos. Those came with a fairly
> busted variant of Open Firmware which generated a pretty gross
> device-tree.
> 
> For some reason, the manufacturer of those things was never willing to
> fix anything in their firmware (despite the distributor providing
> patches etc...), seemingly on the assumption that whatever they were
> doing was perfect and operating system people like us didn't matter one
> little bit :-)
> 
> So I don't care much about it. It would be nice to keep them working
> since people in the community still have them but if it goes through
> some "compat" code that detects old/broken device-trees and eventually
> disappears when we finally drop support, then so be it.

Ian,

What is the status of this work?

thx,

Jason.
