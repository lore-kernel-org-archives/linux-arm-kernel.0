From: tony@atomide.com (Tony Lindgren)
Date: Thu, 9 Dec 2010 16:30:00 -0800
Subject: [PATCH] OMAP1: SRAM: fix size for OMAP1611 SoCs
In-Reply-To: <1291770132-2283-1-git-send-email-khilman@deeprootsystems.com>
References: <1291770132-2283-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <20101210002959.GN3054@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [101207 17:06]:
> Kernel was failing to boot on omap1611 based OSK boards due to
> mis-configured SRAM size.  Existing code was using a hard-coded value
> for 250k, which was then rounded down by PAGE_SIZE.  Increasing this to
> 256k allows kernel to boot on omap1611 SoCs.
> 
> Problem reported by and initial fix suggested by Tim Bird.
> 
> Thanks to Tony Lindgren for helping diagnose the problem to being
> specific to OMAP1611 and not affecting OMAP1610/OMAP1623.

Thanks, will queue this fix.

Tony
