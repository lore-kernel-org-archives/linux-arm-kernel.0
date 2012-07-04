From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Jul 2012 08:44:08 +0000
Subject: [PATCH] ARM: imx: Fix build error due to missing irqs.h include
In-Reply-To: <20120704033018.GA1862@S2100-06.ap.freescale.net>
References: <1341365144-4549-1-git-send-email-festevam@gmail.com>
 <20120704033018.GA1862@S2100-06.ap.freescale.net>
Message-ID: <201207040844.09385.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 July 2012, Shawn Guo wrote:
> 
> Dammit.  I forgot testing imx_v4_v5_defconfig again with the last FIQ
> change.  Thanks, Fabio.
> 
> Arnd,
> 
> I just updated the branch imx/sparse-irq with this fix applied.  Can
> you please pull it?

In the train at the moment without internet access, so I just applied
the patch and added your S-o-b, on top of the next/irq branch.

	Arnd
