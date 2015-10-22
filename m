From: jonmason@broadcom.com (Jon Mason)
Date: Thu, 22 Oct 2015 10:16:19 -0400
Subject: [PATCH v3 0/10] clk: iproc: add support for BCM NS, NSP, and NS2
In-Reply-To: <20151021235144.GQ19782@codeaurora.org>
References: <1444938513-10758-1-git-send-email-jonmason@broadcom.com>
 <20151021235144.GQ19782@codeaurora.org>
Message-ID: <20151022141618.GC651@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 04:51:44PM -0700, Stephen Boyd wrote:
> On 10/15, Jon Mason wrote:
> > 
> > v3 - Added a patch to fix cygnus clk link failures, and added back the
> > DT documentation patches that were removed from v2.
> > 
> > v2 - Added a patch to change the Cygnus clk macros to uppercase,
> > removed the device tree changes from the series (will send out those as
> > an RFC), and other minor changes that Stephen Boyd requested.
> > 
> > This patch series adds support for the Broadcom Northstar, Northstar
> > Plus, and Northstar 2 clocks.  Some slight modifications were necessary
> > to clk-iproc-pll to get Northstar and Northstar Plus working, due to
> > differences in register layout.  This is the reason why the first patch
> > is necessary.  Some more modifications were necessary to clk-iproc-pll
> > to get Northstar 2 working, due to differences in register layout (and
> > resulting fallout in Cygnus and NSP).  This is the reason why the sixth
> > and seventh patches are necessary.  The fifth patch is clean-up to
> > prevent accidentally forgetting to adjust for the base write errata
> > (which happened a few times, but was caught in internal review).
> > 
> 
> Can you please use git cover-letter format where the diffstat for
> the series is shown? Without that information here I started
> applying patches until I realized this added dt-bindings headers,
> thus probably needing some stable clk branch to pull into arm-soc.

My apologies.  I will do so in the future.

Thanks,
Jon

> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
