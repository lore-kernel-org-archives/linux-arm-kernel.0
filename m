From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 29 Apr 2014 11:34:00 +0100
Subject: [PATCH v6 3/5] devicetree: bindings: Document Krait cache error
 interrupts
In-Reply-To: <20140408153925.GJ30077@pd.tnic>
References: <1396641450-12854-1-git-send-email-sboyd@codeaurora.org>
 <1396641450-12854-4-git-send-email-sboyd@codeaurora.org>
 <20140408153925.GJ30077@pd.tnic>
Message-ID: <20140429103400.GB22015@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 04:39:25PM +0100, Borislav Petkov wrote:
> On Fri, Apr 04, 2014 at 12:57:28PM -0700, Stephen Boyd wrote:
> > The Krait L1/L2 error reporting hardware is made up a per-CPU
> > interrupt for the L1 cache and a SPI interrupt for the L2.
> > 
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Kumar Gala <galak@codeaurora.org>
> > Cc: <devicetree@vger.kernel.org>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  Documentation/devicetree/bindings/arm/cache.txt | 48 ++++++++++++++++++++++++-
> >  1 file changed, 47 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/cache.txt b/Documentation/devicetree/bindings/arm/cache.txt
> > index b90fcc7c53cf..d7357e777399 100644
> > --- a/Documentation/devicetree/bindings/arm/cache.txt
> > +++ b/Documentation/devicetree/bindings/arm/cache.txt
> 
> Right, that's http://www.spinics.net/lists/arm-kernel/msg308540.html
> 
> So whoever picks those patches up, Lorenzo's doc needs to be in his tree
> first too.

Sorry for the delay in replying. Those cache bindings need an ACK to get
merged, and were introduced so that idle states can retrieve power domain
information for caches. I am going to revive the idle bindings thread
to see what we can/should merge of these bindings as things stand, I
really hope this won't block the series any further, otherwise we can
rework the patches so that this series can get in first, or simplify my
series to allow both to get merged as soon as possible without compromising
future requirements.

Thanks,
Lorenzo
