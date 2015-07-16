From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 16 Jul 2015 05:41:29 +0000 (UTC)
Subject: [PATCH 1/2] ARM: OMAP2+: sparse: add missing static
 declaration
In-Reply-To: <21cca39eea23dfac76e6752fa2b2b62a4b1e15ad.1436622578.git.nsekhar@ti.com>
References: <cover.1436622578.git.nsekhar@ti.com>
 <21cca39eea23dfac76e6752fa2b2b62a4b1e15ad.1436622578.git.nsekhar@ti.com>
Message-ID: <alpine.DEB.2.02.1507160541090.32764@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 11 Jul 2015, Sekhar Nori wrote:

> Add missing static declaration for file local variables.
> This fixes sparse warnings of type:
> 
> arch/arm/mach-omap2/omap_hwmod_81xx_data.c:491:26: warning: symbol 'dm81xx_alwon_l3_slow__gpmc' was not declared. Should it be static?
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Thanks, queued for v4.3.


- Paul
