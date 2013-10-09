From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 9 Oct 2013 13:27:56 -0400 (EDT)
Subject: [RFC PATCH 1/4] ARM: Allow assembler.h to be used with inline asm
In-Reply-To: <20131009171202.GD2306@localhost.localdomain>
References: <20131009171202.GD2306@localhost.localdomain>
Message-ID: <alpine.LFD.2.03.1310091327260.3023@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Oct 2013, Dave Martin wrote:

> On Wed, Oct 09, 2013 at 12:54:31PM -0400, Nicolas Pitre wrote:
> > On Wed, 9 Oct 2013, Dave Martin wrote:
> > 
> > > It could make sense to add the new helper to asm/swab.h, but that might
> > > result in pollution when it's included via linux/swab.h.
> > 
> > Yet its name is specific enough that this is rather unlikely.  So maybe 
> > this would be the best compromize.
> 
> You mean the names of the introduced macros?

Yes.


Nicolas
