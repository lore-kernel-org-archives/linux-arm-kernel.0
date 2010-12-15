From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 14 Dec 2010 18:10:35 -0700 (MST)
Subject: [PATCH 5/5] OMAP4: hwmod & clock data: Fix GPIO opt_clks and
	ocp_if iclk
In-Reply-To: <1291937615-18571-6-git-send-email-b-cousson@ti.com>
References: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
	<1291937615-18571-6-git-send-email-b-cousson@ti.com>
Message-ID: <alpine.DEB.2.00.1012141810030.15971@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Dec 2010, Benoit Cousson wrote:

> Fix opt clocks name in clock framework and hwmod.
> 
> Add the missing iclk in the ocp_if structure.
> 
> Add the HWMOD_CONTROL_OPT_CLKS_IN_RESET flag to ensure
> the the GPIO optional clock is enable during reset.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Tested-by: Charulatha V <charu@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

This one I just tweaked the commit message slightly on.  Revised message 
is below.


- Paul


    OMAP4: hwmod & clock data: Fix GPIO opt_clks and ocp_if iclk
    
    Fix opt clocks name in clock framework and hwmod.
    
    Add the missing iclk in the ocp_if structure.
    
    Add the HWMOD_CONTROL_OPT_CLKS_IN_RESET flag to ensure
    that the GPIO optional clock is enabled during reset, since
    it must be enabled for the IP block to reset successfully.
    
    Signed-off-by: Benoit Cousson <b-cousson@ti.com>
    Tested-by: Charulatha V <charu@ti.com>
    [paul at pwsan.com: fix the commit message]
    Signed-off-by: Paul Walmsley <paul@pwsan.com>
    Cc: Rajendra Nayak <rnayak@ti.com>
