From: david@gibson.dropbear.id.au (David Gibson)
Date: Wed, 2 Oct 2013 18:24:02 +1000
Subject: [RFC 00/15] Device Tree schemas and validation
In-Reply-To: <E1VR1hx-0000C1-6J@jdl.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
 <524A8289.3050107@baylibre.com> <524ACB76.1010001@gmail.com>
 <524AE4FB.4080906@baylibre.com> <E1VR1hx-0000C1-6J@jdl.com>
Message-ID: <20131002082402.GE6506@voom.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 10:17:53AM -0500, Jon Loeliger wrote:
> > Hi Rob,
> > 
> > On 01/10/2013 15:17, Rob Herring wrote:
> > > On 10/01/2013 03:06 AM, Benoit Cousson wrote:
> > >> + more DT maintainers folks
> > >>
> > >> Hi all,
> > >>
> > >> I know this is mostly boring user space code, but I was expecting a
> > >> little bit of comments about at least the bindings syntax:-(
> > >>
> > >> I'd like to know if this is the right direction and if it worth pursuing
> > >> in that direction.
> > >>
> > >> The idea was to have at least some base for further discussion during
> > >> ARM KS 2013.
> > >>
> > >> I feel alone :-(
> > >>
> > >> If you have any comment, go ahead!
> 
> 
> Benoit,
> 
> Sorry, I meant to ask earlier but forgot.
> Shouldn't this development be based on the
> upstream DTC repository and not the in-kernel
> copy of the DTC?

Absolutely.  Please work against upstream dtc.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131002/982f4d1c/attachment-0001.sig>
