From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 6 Sep 2015 08:45:31 +0800
Subject: [PATCH] arm:irqchip: IRQCHIP_DECLARE macro is now accessible
In-Reply-To: <7212409.q6uiaM0l3x@joel-zenbook>
References: <1436299411-12329-1-git-send-email-joel@porquet.org>
 <20150713152035.GD26642@tiger> <7212409.q6uiaM0l3x@joel-zenbook>
Message-ID: <20150906004531.GA30746@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 04:54:21PM -0400, Joel Porquet wrote:
> On Monday, July 13, 2015 11:20:35 PM Shawn Guo wrote:
> > On Tue, Jul 07, 2015 at 04:02:53PM -0400, Joel Porquet wrote:
> > > The IRQCHIP_DECLARE macro migrated to 'include/linux/irqchip.h', making it
> > > globally accessible.
> > > 
> > > See commit 91e20b5040c67c51aad88cf87db4305c5bd7f79d
> > > ("irqchip: Move IRQCHIP_DECLARE macro to include/linux/irqchip.h").
> > > 
> > > This patch adds inclusions of 'include/linux/irqchip.h' and replaces uses
> > > of macro OF_DECLARE_2 with IRQCHIP_DECLARE.
> > > 
> > > Signed-off-by: Joel Porquet <joel@porquet.org>
> > > ---
> > 
> > ...
> > 
> > >  arch/arm/mach-imx/gpc.c              | 7 ++-----
> > 
> > Acked-by: Shawn Guo <shawnguo@kernel.org>
> > 
> > How will this patch be sent to upstream?
> 
> If it's more convenient for the different maintainers affected by this patch, 
> I can probably resubmit it into a series of patches that modify each file 
> separately... Let me know quickly so we don't miss the merge window!

We had sent out the materials for this merge window.  So if you have a
path to upstream, you'd better send this patch through that.  You've
already got the ACKs from maintainers of affected platform.

Shawn
