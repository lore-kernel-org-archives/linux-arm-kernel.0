From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 23 May 2011 15:23:09 +0530
Subject: [PATCH] Fix generic irq chip
In-Reply-To: <20110520220510.GC30675@n2100.arm.linux.org.uk>
References: <20110520220510.GC30675@n2100.arm.linux.org.uk>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D09B1F7@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 21, 2011 at 03:35:10, Russell King - ARM Linux wrote:
> As a result of c42321c (genirq: Make generic irq chip depend on
> CONFIG_GENERIC_IRQ_CHIP), we now need those platforms using this in
> my tree to select this symbol.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> --
> Please send acks ASAP.  Thanks to Mark for pointing this out with a patch
> for Samsung.

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
