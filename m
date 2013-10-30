From: marex@denx.de (Marek Vasut)
Date: Wed, 30 Oct 2013 10:54:50 +0100
Subject: [PATCH] PCI: imx6: increase link startup
In-Reply-To: <20131029222036.GB15159@google.com>
References: <1382505138-23286-1-git-send-email-tharvey@gateworks.com>
 <20131029222036.GB15159@google.com>
Message-ID: <201310301054.50502.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bjorn Helgaas,

> On Tue, Oct 22, 2013 at 10:12:18PM -0700, Tim Harvey wrote:
> > An increase link startup delay is required when certain PCI switches are
> > attached to the root complex.  This was tested with a Pericom switch
> > and a PLX switch.
> > 
> > From: Marek Vasut <marex@denx.de>
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Acked-by: Tim Harvey <tharvey@gateworks.com>
> 
> I applied this with Shawn's ack to my pci/host-imx6 branch for v3.13,
> thanks!
> 
> I assume the intent was that this patch was written by Marek, per the
> "From:" line you added above, so I fixed that in the patch so Marek
> appears as the author.  Let me know if this is incorrect.

I'm really glad Tim split this patch while I am being totally unhelpful here on 
the PCIe front in last few days. Thank you!

Best regards,
Marek Vasut
