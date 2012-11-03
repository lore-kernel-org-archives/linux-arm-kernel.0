From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 3 Nov 2012 21:48:48 +0530
Subject: [PATCH 08/15] ARM: OMAP2+: hwmod: Fix the omap_hwmod_addr_space
 for CPGMAC0
In-Reply-To: <1351859566-24818-9-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-9-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <509543E8.60209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> The first entry for CPGMAC0 should be ADDR_MAP_ON_INIT
> instead of ADDR_TYPE_RT to ensure the omap hwmod code
> maps the memory space at init and writes to the SYSCONFIG
> registers.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
Sorry again similar question.

Why CPGMAC0 should be mapped and sysconfig updated early ?

Regards
Santosh
