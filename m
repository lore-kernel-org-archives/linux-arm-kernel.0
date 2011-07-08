From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 8 Jul 2011 01:35:02 -0600 (MDT)
Subject: [PATCH v2 4/6] OMAP4: clocks: Update the clock tree with 4460
	clock nodes
In-Reply-To: <4E16AD18.7040402@ti.com>
References: <1309573826-10615-1-git-send-email-rnayak@ti.com>
	<1309573826-10615-2-git-send-email-rnayak@ti.com>
	<1309573826-10615-3-git-send-email-rnayak@ti.com>
	<1309573826-10615-4-git-send-email-rnayak@ti.com>
	<1309573826-10615-5-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1107080044270.24181@utopia.booyaka.com>
	<4E16AD18.7040402@ti.com>
Message-ID: <alpine.DEB.2.00.1107080134430.24181@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Jul 2011, Rajendra Nayak wrote:

> On 7/7/2011 11:49 PM, Paul Walmsley wrote:
> > On Sat, 2 Jul 2011, Rajendra Nayak wrote:
> > 
> > > Add the new clock nodes (bandgap_ts_fclk, div_ts_ck) for omap4460.
> > > Handle these nodes using the clock flags (CK_*).
> > > 
> > > Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> > > Signed-off-by: Nishanth Menon<nm@ti.com>
> > > Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> > > Reviewed-by: Kevin Hilman<khilman@ti.com>
> > 
> > Is this data coming from autogenerator scripts that have been checked into
> > that repository, or have these been hand-edited?
> 
> They have been hand edited to create a diff from the 4430 autogen output
> and 4460 autogen output.
> 
> > 
> > Also, this isn't the complete set of clock changes needed for full 4460
> > support, right?  I'm thinking of the duty cycle correction changes
> > described in TRM 3.6.3.7.2 "Tactical Clocking Adjustment".
> > Are those planned to go into a future patch?
> 
> Yes, this series was targeted at providing basic boot support. I was
> planning to add the DCC changes as part of the next series.

Okay.

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
