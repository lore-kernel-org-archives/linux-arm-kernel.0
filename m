From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 03 Feb 2010 11:52:22 +0000
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100203005038.GA16356@caradoc.them.org>
References: <20100203005038.GA16356@caradoc.them.org>
Message-ID: <1265197942.1970.34.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-02-03 at 00:50 +0000, Daniel Jacobowitz wrote:
> On Tue, Feb 02, 2010 at 10:43:22PM +0000, Russell King - ARM Linux
> wrote:
> > Umm, today there were patches posted using hardware support for
> > breakpoints / watchpoints.  I've not read through those patches
> > yet, but in light of hardware support, do we really need this patch
> > anymore?
> 
> Yes, it's unrelated.  Hardware breakpoints are a constrained resource,
> but we can insert unlimited software breakpoints (and often need to
> exceed the hardware breakpoint limit).

I agree, we still need support for software breakpoints.

The main benefit of hardware debugging support is for watchpoints.

-- 
Catalin
