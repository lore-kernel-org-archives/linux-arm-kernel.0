From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 28 Dec 2011 14:27:54 +0800
Subject: [PATCH 1/2] ARM: imx: add dt support of IRAM
In-Reply-To: <4EF9F85E.5020203@gmail.com>
References: <1324949596-27214-1-git-send-email-jason.chen@linaro.org>
 <4EF9F85E.5020203@gmail.com>
Message-ID: <20111228062753.GB17315@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2011 at 10:54:54AM -0600, Rob Herring wrote:
> On 12/26/2011 07:33 PM, Jason Chen wrote:
> > Signed-off-by: Jason Chen <jason.chen@linaro.org>
> > Signed-off-by: Eric Miao <eric.miao@linaro.org>
> > ---
> >  arch/arm/plat-mxc/include/mach/iram.h |    6 ++++++
> >  arch/arm/plat-mxc/iram_alloc.c        |   16 ++++++++++++++++
> >  2 files changed, 22 insertions(+), 0 deletions(-)
> > 
> 
> Whatever happened to the generic SRAM support? That with a common DT
> binding and init would be better.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-May/051472.html
> 
Receiving the patch from Eric and Jason, the first thing I did was
searching the status of SRAM consolidation series.  But it has not got
any update since it's proposed back to May.

-- 
Regards,
Shawn
