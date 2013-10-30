From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 29 Oct 2013 17:34:36 -0700
Subject: [PATCH 4/6] edac: Document Krait L1/L2 EDAC driver binding
In-Reply-To: <20131029050645.GC21983@codeaurora.org>
References: <1383006690-6754-1-git-send-email-sboyd@codeaurora.org>
 <1383006690-6754-5-git-send-email-sboyd@codeaurora.org>
 <20131029013454.GJ4763@kartoffel>
 <20131029050645.GC21983@codeaurora.org>
Message-ID: <20131030003436.GB3268@kartoffel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 05:06:45AM +0000, Stephen Boyd wrote:
> On 10/28, Mark Rutland wrote:
> > On Tue, Oct 29, 2013 at 12:31:28AM +0000, Stephen Boyd wrote:
> > > +
> > > +Optional properties:
> > > +- interrupt-names: Should contain the interrupt names "l1_irq" and
> > > +  "l2_irq"
> > 
> > As with my comment on the parsing code, I'd prefer that if interrupt-names was
> > present it defined the order of interrupts. Otherwise it's redundant and of no
> > value.
> > 
> > Otherwise, the binding looks fine to me:
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> How about I just drop the interrupt-names property? It isn't
> adding much and is a holdover from the vendor kernel.

That's also fine given that this is a very specific binding.

Mark.
