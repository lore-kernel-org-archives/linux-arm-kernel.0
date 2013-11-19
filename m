From: olof@lixom.net (Olof Johansson)
Date: Tue, 19 Nov 2013 10:48:27 -0800
Subject: ACPI vs DT at runtime
In-Reply-To: <20131119091216.GA4412@netboy>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <5289A356.4060004@jonmasters.org>
 <20131118150052.GC24408@sirena.org.uk>
 <20131118191336.GB5886@quad.lixom.net>
 <20131119091216.GA4412@netboy>
Message-ID: <20131119184827.GD20967@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding Grant]

On Tue, Nov 19, 2013 at 10:12:17AM +0100, Richard Cochran wrote:
> On Mon, Nov 18, 2013 at 11:13:36AM -0800, Olof Johansson wrote:
> > 
> > I know people have been frustrated that they need to keep the DT in sync with
> > the kernel. But we've always been upfront with the requirement, and why we've
> > been having it. We're now changing this requirement, which should help sort out
> > practically all of the concerns at hand.
> 
> Sorry, but this really gets my goat. When have you been upfront about
> the unstable DT idea?

As I said, from the very beginning. It's why we decided to have the DTS hosted
in the kernel tree as well. The approach has always been "we'll move it out
eventually when things settle down", but that's always been pushed off so far.

This is just a tangent and a distraction anyway: You should know by
now that we've decided to keep backwards compatibility going forward,
so any argument about why we did it differently before is leading nowhere.


-Olof
