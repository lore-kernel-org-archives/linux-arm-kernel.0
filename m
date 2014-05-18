From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 18 May 2014 19:07:25 -0400
Subject: [PATCHv4 0/5] Add DT support for fixed PHYs
In-Reply-To: <20140518194628.0d0c308d@free-electrons.com>
References: <1400249647-4643-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140516.172009.632611701865367987.davem@davemloft.net>
 <20140518121854.3b4a17fa@free-electrons.com>
 <CAGVrzcYN1-0zM0pVSFZkD5HVAwq6rXEQOBN29x+vBn9hpbmOcA@mail.gmail.com>
 <20140518194628.0d0c308d@free-electrons.com>
Message-ID: <20140518230725.GY27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 18, 2014 at 07:46:28PM +0200, Thomas Petazzoni wrote:
> Dear Florian Fainelli,
> 
> On Sun, 18 May 2014 10:21:10 -0700, Florian Fainelli wrote:
> 
> > > On Fri, 16 May 2014 17:20:09 -0400 (EDT), David Miller wrote:
> > >> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > >> Date: Fri, 16 May 2014 16:14:02 +0200
> > >>
> > >> > Here is a fourth version of the patch set that adds a Device Tree
> > >> > binding and the related code to support fixed PHYs. I'm hoping to get
> > >> > this merged in 3.16.
> > >>
> > >> Series applied, thanks Thomas.
> > >
> > > Thanks! Did you also pull PATCH 5/5, which changes the Armada XP Matrix
> > > Device Tree file?
> > 
> > It has been applied:
> > http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/?id=84f6e11f21d40025ae9b0ebbf1c9b3be91ea8e1a
> 
> I think it should have been routed through the mvebu tree, or at least
> get the hack of the mvebu maintainers. That being said, I don't think
> we have other patches for armada-xp-matrix.dts in this cycle, so maybe
> having this patch go through David's tree will be OK. I'll let Jason
> Cooper (Cc'ed) answer on this.

There's just one patch:

  0d9179fb3369 ARM: mvebu: remove clock-frequency of serial port Device Tree nodes

Which removes a single line.  So it should be trivial to resolve any conflict.

In the future: Yes, we prefer to take the dts file changes.  But I don't
see a problem here.  Thanks for the heads up, though.

thx,

Jason.
