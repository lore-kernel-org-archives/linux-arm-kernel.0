From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 May 2015 21:25:48 +0200 (CEST)
Subject: [RESEND][ PATCH v3] irqchip/gicv3-its: ITS table size should
 not be smaller than PSZ
In-Reply-To: <1432134795-661-1-git-send-email-stuart.yoder@freescale.com>
References: <1432134795-661-1-git-send-email-stuart.yoder@freescale.com>
Message-ID: <alpine.DEB.2.11.1505202125220.4225@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 May 2015, Stuart Yoder wrote:

> when allocating a device table, if the requested allocation
> is smaller than the default granule size of the ITS
> then, we need to round up to the default size
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>

So who wrote that patch? That's not a valid SOB chain ....
