From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 May 2015 15:30:03 +0200 (CEST)
Subject: [PATCH v3] irqchip/gicv3-its: ITS table size should not be
 smaller than PSZ
In-Reply-To: <1432076441-26365-1-git-send-email-stuart.yoder@freescale.com>
References: <1432076441-26365-1-git-send-email-stuart.yoder@freescale.com>
Message-ID: <alpine.DEB.2.11.1505201528390.4225@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 May 2015, Stuart Yoder wrote:

> when allocating a device table, if the requested allocation
> is smaller than the default granule size of the ITS
> then, we need to round up to the default size
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
>   -v3 changes
>      -updated commit message and added comment
>   -would be nice to get this into 4.1 as the kernel will hang booting
>    on some systems

Would be nice if you would CC all maintainers AND the proper
mailinglist.

Thanks,

	tglx
