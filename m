From: joel@porquet.org (Joel Porquet)
Date: Fri, 04 Sep 2015 16:54:21 -0400
Subject: [PATCH] arm:irqchip: IRQCHIP_DECLARE macro is now accessible
In-Reply-To: <20150713152035.GD26642@tiger>
References: <1436299411-12329-1-git-send-email-joel@porquet.org>
 <20150713152035.GD26642@tiger>
Message-ID: <7212409.q6uiaM0l3x@joel-zenbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 13, 2015 11:20:35 PM Shawn Guo wrote:
> On Tue, Jul 07, 2015 at 04:02:53PM -0400, Joel Porquet wrote:
> > The IRQCHIP_DECLARE macro migrated to 'include/linux/irqchip.h', making it
> > globally accessible.
> > 
> > See commit 91e20b5040c67c51aad88cf87db4305c5bd7f79d
> > ("irqchip: Move IRQCHIP_DECLARE macro to include/linux/irqchip.h").
> > 
> > This patch adds inclusions of 'include/linux/irqchip.h' and replaces uses
> > of macro OF_DECLARE_2 with IRQCHIP_DECLARE.
> > 
> > Signed-off-by: Joel Porquet <joel@porquet.org>
> > ---
> 
> ...
> 
> >  arch/arm/mach-imx/gpc.c              | 7 ++-----
> 
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> 
> How will this patch be sent to upstream?

If it's more convenient for the different maintainers affected by this patch, 
I can probably resubmit it into a series of patches that modify each file 
separately... Let me know quickly so we don't miss the merge window!

Jo?l
