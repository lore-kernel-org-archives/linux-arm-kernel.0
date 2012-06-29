From: afzal@ti.com (Mohammed, Afzal)
Date: Fri, 29 Jun 2012 06:38:32 +0000
Subject: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9A0D32@DBDE01.ent.ti.com>
References: <cover.1340778002.git.afzal@ti.com>
 <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com>
 <20120627145844.GL3483@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com>
 <20120628123207.GG19842@atomide.com> <4FEC89B9.3090404@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A0D32@DBDE01.ent.ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9A0D6B@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 29, 2012 at 11:45:49, Mohammed, Afzal wrote:

> Kernel can't handle gpmc by itself, may be resetting onenand is
> a solution, as it seems bootloader is leaving it in sync mode.

To add, the above solution is made under the assumption that onenand
after reset will be in async mode (based on Samsung datsheet)

Regards
Afzal
