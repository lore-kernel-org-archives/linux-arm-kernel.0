From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 22 Aug 2011 17:03:01 +0200
Subject: [PATCH 3/3] OMAP3: Remove auto-selection of PMICs
In-Reply-To: <1313754573-11498-4-git-send-email-abhilash.kv@ti.com>
References: <1313754573-11498-1-git-send-email-abhilash.kv@ti.com>
	<1313754573-11498-2-git-send-email-abhilash.kv@ti.com>
	<1313754573-11498-3-git-send-email-abhilash.kv@ti.com>
	<1313754573-11498-4-git-send-email-abhilash.kv@ti.com>
Message-ID: <20110822150301.GY4607@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anhilash,

On Fri, Aug 19, 2011 at 05:19:33PM +0530, Abhilash K V wrote:
> The current implementation almost assumes that only
> TWL4030/TWL5030/TWl6030 are (or can be) used with the
> OMAP processors. This is, however, not true.

I don't like the mfd/Kconfig change. Why would those drivers be only buildable
on OMAP processors ?
Unless there is a real reason for this, you should fix the drivers instead.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
