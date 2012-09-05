From: horms@verge.net.au (Simon Horman)
Date: Wed, 5 Sep 2012 17:13:20 +0900
Subject: [PATCH] ARM: shmobile: r8a7779: remove USB phy initializer
In-Reply-To: <w3p4nndz0st.wl%kuninori.morimoto.gx@renesas.com>
References: <1346376502-12114-1-git-send-email-horms@verge.net.au>
 <1346376502-12114-6-git-send-email-horms@verge.net.au>
 <201209032138.41485.arnd@arndb.de>
 <87k3wafxj4.wl%kuninori.morimoto.gx@renesas.com>
 <20120904003402.GE6095@verge.net.au>
 <87ehmifl3b.wl%kuninori.morimoto.gx@renesas.com>
 <20120905012056.GC4232@verge.net.au>
 <20120905012337.GD4232@verge.net.au>
 <w3p4nndz0st.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20120905081319.GD11575@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 11:00:22AM +0900, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > my preferred approach is to drop the following patches from the marzen
> > > branch and get the remaining changes merged (hopefully). Then look at
> > > USB once again.
> > > 
> > > f58f278 ARM: shmobile: marzen: add USB EHCI driver support
> > > 4150c1d ARM: shmobile: r8a7779: add USB OHCI clock support
> > > 535b372c ARM: shmobile: r8a7779: add USB EHCI clock support
> > > f9929ab ARM: shmobile: r8a7779: add USB common phy initializer
> > 
> > and
> > 
> > 3553395 ARM: shmobile: marzen: add USB OHCI driver support
> 
> Thank you for your help

Thanks, I have pushed a rebased marzen tree accordingly.
