From: vinod.koul@intel.com (Koul, Vinod)
Date: Thu, 25 Aug 2011 19:36:15 +0530
Subject: [PATCH V3 00/20] dmaengine/amba-pl08x updates
In-Reply-To: <CACRpkdY6KW+tv7H==b15xJyeLp9HCqp9ROBhON0A8JnJDUn8Kg@mail.gmail.com>
References: <cover.1312538034.git.viresh.kumar@st.com>
	<CACRpkdY6KW+tv7H==b15xJyeLp9HCqp9ROBhON0A8JnJDUn8Kg@mail.gmail.com>
Message-ID: <1314281175.1606.36.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-08-23 at 10:17 +0200, Linus Walleij wrote:
> On Fri, Aug 5, 2011 at 12:02 PM, Viresh Kumar <viresh.kumar@st.com> wrote:
> 
> > This patchset contains patches for ARM's pl08x DMA controller driver.
> > Main changes introduced by this patchset are:
> > - Formatting fixes
> > - Logical Fixes
> > - Support for Peripheral as flow controller
> > - Support for sg_len to be greater than 1 for slave transfers
> > - Schedule tasklet for error interrupts
> > - remove pl08x_pre_boundary() routine
> > - support for runtime PM
> > - etc
> 
> I've now tested this patchset:
> 
> patch 3/20 fails to apply cleanly, need rebase on top of Russell's
> fix for dma-mapping.h inclusion. It's a trivial fix.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Vinod could you apply all patches except for 16/18 which has some
> discussion going on, so we get some rotation in -next? The rest of
> Viresh:s patches are really nice stuff to have.
> 
> I will test on the PB11MPcore in the next few days.
> 
Thanks, I have applied this patch series to 17/20

-- 
~Vinod
