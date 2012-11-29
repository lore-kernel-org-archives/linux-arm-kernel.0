From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 29 Nov 2012 11:21:57 +0000 (UTC)
Subject: [PATCH 0/3] ARM: OMAP4: Clock fixes
In-Reply-To: <1352313782-21602-1-git-send-email-jon-hunter@ti.com>
References: <1352313782-21602-1-git-send-email-jon-hunter@ti.com>
Message-ID: <alpine.DEB.2.00.1211291120220.20529@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Wed, 7 Nov 2012, Jon Hunter wrote:

> Fixes included, fixing up timer clock aliases for v3.8 and working
> around ABE DPLL issue seen with latest u-boot bootloader (v2012.10).
> 
> Testing includes:
> - Boot testing on OMAP3430 Beagle, OMAP4430 Panda and OMAP4460 Panda
> - Boot tested with device-tree on OMAP4430 Panda and OMAP4460 Panda
>   and validated that all timers are working.
> - Suspend testing on OMAP3430 Beagle and OMAP4430 Panda (suspend not
>   functional on OMAP4460 Panda prior to this series and so could not
>   be tested).
> - Core retention validated on OMAP3430 Beagle.
> 
> Jon Hunter (3):
>   ARM: OMAP4: Update timer clock aliases
>   ARM: OMAP4: Enhance support for DPLLs with 4X multiplier
>   ARM: OMAP4460: Workaround ABE DPLL failing to turn-on

So I'd plan to queue #2 and #3 for v3.8-rc1.  But they need to be updated 
after the common clock framework conversion.  Could you update those to 
apply on the arm-soc for-next branch?
 

- Paul
