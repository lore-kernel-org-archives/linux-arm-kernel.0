From: shijie8@gmail.com (Huang Shijie)
Date: Sun, 10 Nov 2013 15:17:24 -0500
Subject: [PATCH bugfix] mtd: gpmi: serialize all the dma operations
In-Reply-To: <20131107211229.GY20061@ld-irv-0074.broadcom.com>
References: <1383728007-15564-1-git-send-email-b32955@freescale.com>
 <20131107211229.GY20061@ld-irv-0074.broadcom.com>
Message-ID: <20131110201722.GA32547@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 07, 2013 at 01:12:29PM -0800, Brian Norris wrote:
> sufficiently well described, and I'm not sure this is the right
> solution. But please, educate me.
I find a better way to synchronize the two DMA operations.
I will send out the new patch after i test it.

thanks
Huang Shijie
