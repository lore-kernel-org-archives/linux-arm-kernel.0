From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 20 May 2013 14:39:21 +0000 (UTC)
Subject: [PATCH-V2] ARM: OMAP2+: AM33xx: Fix missing reset status data
 to GFX hwmod
In-Reply-To: <1369057116-31423-1-git-send-email-hvaibhav@ti.com>
References: <1369057116-31423-1-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.02.1305201439020.6174@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 May 2013, Vaibhav Hiremath wrote:

> GFX has a reset status register (PRM_GFX.RM_GFX_RSTST),
> so update the GFX hwmod data with .rstst_off and .st_shift
> information.
> 
> Although it doesn't have impact on kernel boot, but this is
> regression fix from original hwmod commit.
> 

Did it ever work?  If not, then it's not a regression, right?


- Paul
