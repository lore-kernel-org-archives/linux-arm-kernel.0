From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 9 Dec 2012 20:38:37 +0000 (UTC)
Subject: [PATCH V2 0/4] ARM: OMAP4: Clock fixes
In-Reply-To: <1354567275-6447-1-git-send-email-jon-hunter@ti.com>
References: <1354567275-6447-1-git-send-email-jon-hunter@ti.com>
Message-ID: <alpine.DEB.2.00.1212092038240.351@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Dec 2012, Jon Hunter wrote:

> Fixes included, fixing up timer clock aliases for v3.8 and working
> around ABE DPLL issue seen with latest u-boot bootloader (v2012.10).
> 
> Testing includes:
> - Boot testing on OMAP4460 Panda and verifying that all dmtimers are
>   working.
> 
> V2 changes:
> - Updated series to latest ARM-SoC for-next branch that includes common
>   clock updates for OMAP4.
> - Added new function table for non-M4X DPLLs which is now required after
>   enhancing support for OMAP4 DPLLs for 4X multiplier.

Thanks, queued for 3.8-rc.


- Paul
