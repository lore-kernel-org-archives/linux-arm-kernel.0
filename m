From: horms@verge.net.au (Simon Horman)
Date: Wed, 25 Sep 2013 14:19:29 +0900
Subject: [PATCH] ARM: shmobile: Break out R-Car Gen2 setup code
In-Reply-To: <20130912005504.GH23279@verge.net.au>
References: <20130912003249.24015.41583.sendpatchset@w520>
 <20130912004730.GG23279@verge.net.au>
 <20130912005504.GH23279@verge.net.au>
Message-ID: <20130925051928.GH24243@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 09:55:06AM +0900, Simon Horman wrote:
> On Thu, Sep 12, 2013 at 09:47:32AM +0900, Simon Horman wrote:
> > On Thu, Sep 12, 2013 at 09:32:49AM +0900, Magnus Damm wrote:
> > > From: Magnus Damm <damm@opensource.se>
> > > 
> > > Move arch timer workaround code and boot mode pin
> > > handling from setup-r8a7790.c to setup-rcar-gen2.c.
> > > 
> > > With this in place the same code can be used on
> > > other R-Car Generation 2 devices such as r8a7791.
> > 
> > This seems reasonable to me.
> > 
> > Am I correct in thinking that you plan a follow-up patch to make use of
> > this on the r8a7771 in the not to distant future.
> 
> I see my reply was too hasty and you have sent such a patch.
> Sorry for the noise!

I have queued up the following as a cleanup and
I plan to push it later this afternoon.

There were some minor conflicts in arch/arm/mach-shmobile/Makefile
and arch/arm/mach-shmobile/include/mach/r8a7790.h.
Please let me know if I messed things up.
