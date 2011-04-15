From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 15 Apr 2011 16:49:15 +0530
Subject: [PATCH] DA830: fix SPI1 base address
In-Reply-To: <201104062117.22238.sshtylyov@ru.mvista.com>
References: <201104062117.22238.sshtylyov@ru.mvista.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C960805@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2011 at 22:47:21, Sergei Shtylyov wrote:
> Commit 54ce6883d29630ff334bee4256a25e3f8719a181 (davinci: da8xx: add spi
> resources and registration routine) wrongly assumed that SPI1 is mapped at
> the same address on DA830/OMAP-L137 and DA850/OMAP-L138; actually, the base
> address was valid only for the latter SoC. Teach the code to pass the correct
> SPI1 memory resource for both SoCs...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> The patch is against the recent DaVinci tree.  It's needed in 2.6.39.

Thanks Sergei, will queue this for 2.6.39

Regards,
Sekhar
