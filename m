From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2012 10:11:23 +0000
Subject: [PATCH 3/3] ARM: OMAP2+: Mark omap_hsmmc_init and omap_mux
 related functions as __init
In-Reply-To: <20120215182829.18884.69168.stgit@kaulin.local>
References: <20120215182355.18884.18682.stgit@kaulin.local>
 <20120215182829.18884.69168.stgit@kaulin.local>
Message-ID: <20120216101123.GI15338@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 10:28:30AM -0800, Tony Lindgren wrote:
> Now that omap hsmmc init is split into two functions, it's safe
> to mark omap_hsmmc_init and omap_mux related functions to __init.
> 
> This basically reverts the following fixes for the case where
> TWL was compiled as a module:
> 
> d5de63 (ARM: omap: preemptively fix section mismatch in omap4_sdp4430_wifi_mux_init())

Why did you include this one?  This is unrelated to the TWL problems.
