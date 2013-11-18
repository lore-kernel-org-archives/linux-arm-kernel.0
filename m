From: olof@lixom.net (Olof Johansson)
Date: Mon, 18 Nov 2013 11:13:36 -0800
Subject: ACPI vs DT at runtime
In-Reply-To: <20131118150052.GC24408@sirena.org.uk>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <5289A356.4060004@jonmasters.org>
 <20131118150052.GC24408@sirena.org.uk>
Message-ID: <20131118191336.GB5886@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding back devicetree at vger.kernel.org]

On Mon, Nov 18, 2013 at 03:00:52PM +0000, Mark Brown wrote:
> On Mon, Nov 18, 2013 at 12:19:18AM -0500, Jon Masters wrote:
> 
> > has an API enshrined in stone as far as compatibility. Device Tree is
> > wonderful, anyone can make a binding and use it. Or change the binding
> > in the next kernel release. Or...this doesn't work in the server space.
> 
> This isn't really a property of DT, it's a property of the way people
> have been using the DT - people have been running with baked in DTs on
> PowerPC and SPARC systems for quite some time now.  It's not obvious how
> writing the data out in one format rather than another addresses this.

+1. And we're now changing the way DT is approached in a manner that will
solve this problem.

I know people have been frustrated that they need to keep the DT in sync with
the kernel. But we've always been upfront with the requirement, and why we've
been having it. We're now changing this requirement, which should help sort out
practically all of the concerns at hand.


-Olof
