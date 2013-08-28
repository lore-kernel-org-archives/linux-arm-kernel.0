From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 28 Aug 2013 18:48:40 +0000 (UTC)
Subject: [PATCH 1/3] ARM: AM33xx: hwmod: Add RNG module data
In-Reply-To: <1375777984-6267-2-git-send-email-lokeshvutla@ti.com>
References: <1375777984-6267-1-git-send-email-lokeshvutla@ti.com>
 <1375777984-6267-2-git-send-email-lokeshvutla@ti.com>
Message-ID: <alpine.DEB.2.02.1308281845560.22040@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, 6 Aug 2013, Lokesh Vutla wrote:

> Add RNG hwmod data for AM33xx SoC.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

I tried to queue this one, but it caused AM33xx boots to hang.  
Thought it might be related to the patch ordering -- seems to me that 
the clock change patch needed to come before this patch -- but if I 
recall correctly, both BeagleBone and BeagleBone-LT still hung.  

Also, this patch created a sparse warning.

Could you take another look at this patch?  Maybe try basing off of this 
tag:

git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.12/omap-prcm-hwmod

Fix the sparse problem, and see if the patch boots for you?

thanks


- Paul
