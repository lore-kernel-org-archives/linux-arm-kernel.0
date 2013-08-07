From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 08 Aug 2013 08:45:36 +1000
Subject: [PATCHv7 07/13] irqdomain: add function to find a MSI irq_domain
In-Reply-To: <1375915344.12551.6.camel@pasglop>
References: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375867954-2320-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375908620.9300.3.camel@pasglop> <20130808000443.17f57875@skate>
 <1375914665.12551.5.camel@pasglop> <1375915344.12551.6.camel@pasglop>
Message-ID: <1375915536.12551.9.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-08-08 at 08:42 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2013-08-08 at 08:31 +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2013-08-08 at 00:04 +0200, Thomas Petazzoni wrote:
> > > Again, this has been discussed at lengths in the previous iterations,
> > > for which I already gave you all the links, as you requested in a
> > > private e-mail. It'd be great if this discussion was read seriously,
> > > because I really have the feeling we are restarting from zero on this
> > > whole MSI thing...
> > 
> > Well, two things here:
> > 
> >  - You don't need my ack since I am not the maintainer of the irqdomain
> > code anymore, Grant is :-)
> 
> Hrm, I'm being told Grant isn't anymore... I can step in and take it all
> back but you might not like the result ....

Oh but it looks like MAINTAINERS says I am :-)

Ok so from that perspective, I don't like it at all. You can try to
convince me otherwise but I don't think we need to introduce a
dependency to something like msi into the core remapper. It's already to
complex.

Why don't you move the powerpc bitmap allocator over to a generic
place ? I feel like it would be actually simpler but feel free to prove
me wrong.

Ben.
