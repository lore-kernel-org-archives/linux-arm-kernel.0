From: jonmason@broadcom.com (Jon Mason)
Date: Tue, 13 Oct 2015 17:10:13 -0400
Subject: [PATCH v2 0/10] clk: iproc: add support for BCM NS, NSP, and NS2
In-Reply-To: <1444770485-11210-1-git-send-email-jonmason@broadcom.com>
References: <1444770485-11210-1-git-send-email-jonmason@broadcom.com>
Message-ID: <20151013211013.GL12512@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oops, this should be 0/7 not 0/10

On Tue, Oct 13, 2015 at 05:07:58PM -0400, Jon Mason wrote:
> 
> v2 - Added a patch to change the Cygnus clk macros to uppercase,
> removed the device tree changes from the series (will send out those as
> an RFC), and other minor changes that Stephen Boyd requested.
> 
> This patch series adds support for the Broadcom Northstar, Northstar
> Plus, and Northstar 2 clocks.  Some slight modifications were necessary
> to clk-iproc-pll to get Northstar and Northstar Plus working, due to
> differences in register layout.  This is the reason why the first patch
> is necessary.  Some more modifications were necessary to clk-iproc-pll
> to get Northstar 2 working, due to differences in register layout (and
> resulting fallout in Cygnus and NSP).  This is the reason why the sixth
> and seventh patches are necessary.  The fifth patch is clean-up to
> prevent accidentally forgetting to adjust for the base write errata
> (which happened a few times, but was caught in internal review).
> 
> Thanks,
> Jon
