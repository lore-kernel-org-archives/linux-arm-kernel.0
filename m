From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 5 Jan 2012 15:32:01 +0800
Subject: [PATCH 2/2] ARM: imx6q: add cpu suspend/resume support in IRAM
In-Reply-To: <20120104091355.GG2914@n2100.arm.linux.org.uk>
References: <1325312624-22980-1-git-send-email-jason.chen@linaro.org>
 <20120104091355.GG2914@n2100.arm.linux.org.uk>
Message-ID: <20120105073200.GF14741@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2012 at 09:13:55AM +0000, Russell King - ARM Linux wrote:
> On Sat, Dec 31, 2011 at 02:23:44PM +0800, Jason Chen wrote:
> > +		imx6q_iram_pm.suspend_iram_vaddr =
> > +			__arm_ioremap(imx6q_iram_pm.suspend_iram_paddr,
> > +					imx6q_iram_pm.suspend_iram_size,
> > +					MT_MEMORY_NONCACHED);
> 
> Stop going beneath the API covers.
> 
Assume that you are suggesting __arch_ioremap() should be used instead,
correct?

-- 
Regards,
Shawn
