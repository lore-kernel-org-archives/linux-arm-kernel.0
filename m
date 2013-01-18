From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 18 Jan 2013 07:56:45 +0100
Subject: [PATCH] ARM: shmobile: sh73a0: Use generic irqchip_init()
In-Reply-To: <20130118000517.GI16740@verge.net.au>
References: <1358424013-31306-1-git-send-email-thierry.reding@avionic-design.de>
 <20130118000517.GI16740@verge.net.au>
Message-ID: <20130118065645.GC17790@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 09:05:17AM +0900, Simon Horman wrote:
> On Thu, Jan 17, 2013 at 01:00:13PM +0100, Thierry Reding wrote:
> > The asm/hardware/gic.h header does no longer exist and the corresponding
> > functionality was moved to linux/irqchip.h and linux/irqchip/arm-gic.h
> > respectively. gic_handle_irq() and of_irq_init() are no longer available
> > either and have been replaced by irqchip_init().
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> 
> Thanks.
> 
> Due to the hairy upstream requirements of the arm-soc tree
> I believe this patch needs to be split in two. A 'board' patch
> for board-kzm9g-reference.c. And an 'soc' patch for the
> remaining portions.
> 
> I'm happy to split the patch myself or for you to do so.

I'll resend a split patch shortly.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130118/1080fbf2/attachment.sig>
