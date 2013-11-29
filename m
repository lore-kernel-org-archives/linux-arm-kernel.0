From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Fri, 29 Nov 2013 18:58:51 +0100
Subject: [PATCH v3 0/3] (U)EFI runtime services for arm
In-Reply-To: <20131129115319.GC11775@console-pimps.org>
References: <1385656883-4420-1-git-send-email-leif.lindholm@linaro.org>
 <20131129115319.GC11775@console-pimps.org>
Message-ID: <20131129175850.GW24997@rocoto.smurfnet.nu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 11:53:19AM +0000, Matt Fleming wrote:
> On Thu, 28 Nov, at 04:41:20PM, Leif Lindholm wrote:
> > In systems based on [U]EFI-conformant firmware, runtime services provide
> > a standardised way for the kernel to update firmware environment
> > variables. This is used for example by efibootmgr to update which image
> > should be loaded on next boot.
> > 
> > This patchset implements basic support for UEFI runtime services on ARM
> > platforms, as well as the basic underlying EFI support. It also defines
> > a mechanism by which the required information is passed from the
> > bootloader (the EFI stub submitted separately) to the kernel via FDT
> > entries.
> 
> This all looks pretty good to me. Is this series going through the ARM
> trees?

Thanks.
That's the plan.

/
    Leif
