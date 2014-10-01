From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 1 Oct 2014 14:48:02 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20141001123250.GY4273@sirena.org.uk>
References: <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
 <20140929155517.GR16977@sirena.org.uk>
 <20140930050923.GB29874@ulmo> <20140930173928.GH4273@sirena.org.uk>
 <20141001074139.GB18463@ulmo>
 <CABxcv=nKErHGPRLM5yer2YnOc2VJPWLmeKgwXbXEU3r_XvsCyg@mail.gmail.com>
 <20141001123250.GY4273@sirena.org.uk>
Message-ID: <20141001124800.GA21733@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 01:32:50PM +0100, Mark Brown wrote:
> On Wed, Oct 01, 2014 at 01:10:46PM +0200, Javier Martinez Canillas wrote:
[...]
> > Adding your resources (clock, regulators, etc) incrementally and only
> > when the driver for the device that use these resources is available,
> > will only make adding support for a new platform slower IMHO since
> > there will be more patches to be posted, reviewed and merged.
> 
> So don't do that if you're worried about it then, provide the bits of DT
> that hook everything up from the start or otherwise describe things as
> being in use.

"Otherwise describe things as being in use" doesn't work for clocks for
example. And Mike already said he wasn't willing to add something like
an always-on DT property for clocks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141001/d3972a47/attachment.sig>
