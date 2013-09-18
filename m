From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 18 Sep 2013 15:23:29 -0500
Subject: [PATCHv6 00/13] MSI support for Marvell EBU PCIe driver
In-Reply-To: <1375828754.12557.70.camel@pasglop>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130806201000.3e97c63b@skate> <1375828754.12557.70.camel@pasglop>
Message-ID: <20130918202329.81368C42CF3@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 07 Aug 2013 08:39:14 +1000, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Tue, 2013-08-06 at 20:10 +0200, Thomas Petazzoni wrote:
> > Benjamin, Thomas,
> > 
> > This patch set has been around for two months now, and I would really
> > like to see it merged. Your ACKs are the only ones missing to merge the
> > whole thing.
> > 
> > Would you mind having a look at:
> > 
> >  * Patches 4, 5, 6, 7 for Benjamin as the irqdomain maintainer.
> 
> Ah sorry, I wasn't aware you were actually waiting for my acks, I didn't
> read the whole thread, my bad. I'm not irqdomain maintainer btw. I wrote
> the original powerpc implementation but since then it has been taken
> over by Grant and others. But I can certainly comment :-)

When I moved the code I put both your name and mine in the maintainer
file. When I resigned from irq_domain maintainership that left you as
the maintainer by default. :-)

I would /like/ to keep maintaining the code, but as evidenced by my
complete lack of activity on this thread, I don't have the bandwidth
anymore. I'll comment on things whenever I can, but I'm unfortunately
very limited in what I can do.  :-(

g.
