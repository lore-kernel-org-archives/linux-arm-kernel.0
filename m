From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 21 Nov 2013 20:47:04 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <20131121192136.GA16735@n2100.arm.linux.org.uk>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.
 com> <20131115095717.GC1709@e106331-lin.cambridge.arm.com> <5289A356.
 4060004@jonmasters.org> <20131118150052.GC24408@sirena.org.uk> <
 20131118191336.GB5886@quad.lixom.net> <20131119091216.GA4412@netboy> <
 20131119184827.GD20967@quad.lixom.net> <20131120064056.GB5272@netboy> <
 20131121192136.GA16735@n2100.arm.linux.org.uk>
Message-ID: <20131121204704.E4487C40753@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Nov 2013 19:21:36 +0000, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Wed, Nov 20, 2013 at 07:40:57AM +0100, Richard Cochran wrote:
> > Now, I never saw any proclamation or discussion about "DT is in flux"
> > on the arm list. If I had, I surely would have complained, and loudly.
> > AFAICT, this decision was made in rather private circles, but you talk
> > as if this was abundantly clear. *It was not.*
> 
> DT has been discussed several times over this year alone, which
> included discussions about the stability of bindings.  Various
> people in those threads (including myself) have put their views
> forward.
> 
> My position has been that if an interface ends up being published in a
> -final kernel, then it is part of the ABI, because a -final kernel is
> an end-product.  It's a final release which says "we've done the
> development, it's finished for users use."  If it's not then it shouldn't
> be in a -final kernel, or if it has to be there for development purposes,
> it needs to be hidden behind a "this is in development" label.
> 
> I've said that several times in the DT discussions and I believe
> basically been ignored.  Frankly, I've said my bit and I've given up
> caring.

Umm. Not sure why you feel ignored. We're absolutely going for stability
now.

g.
