From: matt@console-pimps.org (Matt Fleming)
Date: Fri, 29 Nov 2013 11:53:19 +0000
Subject: [PATCH v3 0/3] (U)EFI runtime services for arm
In-Reply-To: <1385656883-4420-1-git-send-email-leif.lindholm@linaro.org>
References: <1385656883-4420-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20131129115319.GC11775@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Nov, at 04:41:20PM, Leif Lindholm wrote:
> In systems based on [U]EFI-conformant firmware, runtime services provide
> a standardised way for the kernel to update firmware environment
> variables. This is used for example by efibootmgr to update which image
> should be loaded on next boot.
> 
> This patchset implements basic support for UEFI runtime services on ARM
> platforms, as well as the basic underlying EFI support. It also defines
> a mechanism by which the required information is passed from the
> bootloader (the EFI stub submitted separately) to the kernel via FDT
> entries.

This all looks pretty good to me. Is this series going through the ARM
trees?

-- 
Matt Fleming, Intel Open Source Technology Center
