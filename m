From: broonie@kernel.org (Mark Brown)
Date: Wed, 1 Oct 2014 18:05:17 +0100
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20141001124800.GA21733@ulmo>
References: <20140929101805.GB26008@ulmo> <20140929114643.GB4081@lukather>
 <20140929134708.GB30998@ulmo>
 <20140929155517.GR16977@sirena.org.uk>
 <20140930050923.GB29874@ulmo> <20140930173928.GH4273@sirena.org.uk>
 <20141001074139.GB18463@ulmo>
 <CABxcv=nKErHGPRLM5yer2YnOc2VJPWLmeKgwXbXEU3r_XvsCyg@mail.gmail.com>
 <20141001123250.GY4273@sirena.org.uk> <20141001124800.GA21733@ulmo>
Message-ID: <20141001170517.GF4273@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 02:48:02PM +0200, Thierry Reding wrote:
> On Wed, Oct 01, 2014 at 01:32:50PM +0100, Mark Brown wrote:

> > So don't do that if you're worried about it then, provide the bits of DT
> > that hook everything up from the start or otherwise describe things as
> > being in use.

> "Otherwise describe things as being in use" doesn't work for clocks for
> example. And Mike already said he wasn't willing to add something like
> an always-on DT property for clocks.

That's not the only way of doing things - another way would be to have a
stub driver that just holds the resources while working on getting a
full one in place for example.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141001/8bd9d8e1/attachment.sig>
