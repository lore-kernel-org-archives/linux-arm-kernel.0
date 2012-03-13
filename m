From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 13 Mar 2012 08:22:51 -0600 (MDT)
Subject: [PATCH v2 0/2] Fixes in hwmod reset code
In-Reply-To: <1331647435-31666-1-git-send-email-rnayak@ti.com>
References: <1331647435-31666-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1203130819480.22211@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra

On Tue, 13 Mar 2012, Rajendra Nayak wrote:

> This fixes a couple of issues around hwmod reset
> APIs'.
> Patches are based on 3.3.-rc7.
> 
> Rajendra Nayak (2):
>   ARM: omap: hwmod: Restore sysc after a reset
>   ARM: omap: hwmod: Make omap_hwmod_softreset wait for reset status
> 
>  arch/arm/mach-omap2/omap_hwmod.c |   18 ++++++------------
>  1 files changed, 6 insertions(+), 12 deletions(-)

Could you base this on either my 'hwmod_code_cleanup_3.4' branch or 
'hwmod_enable_remaining_hwmods_devel_3.4' branch?  There are some reset 
changes in there also.


- Paul
