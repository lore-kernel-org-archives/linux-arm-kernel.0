From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 29 Apr 2014 12:24:59 +0100
Subject: [PATCH v2 05/10] efi: Add shared FDT related functions for
 ARM/ARM64
In-Reply-To: <1398442154-19974-6-git-send-email-leif.lindholm@linaro.org>
References: <1398442154-19974-1-git-send-email-leif.lindholm@linaro.org>
 <1398442154-19974-6-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20140429112459.GH26088@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Apr, at 05:09:09PM, Leif Lindholm wrote:
> From: Roy Franz <roy.franz@linaro.org>
> 
> Both ARM and ARM64 stubs will update the device tree that they pass to
> the kernel.  In both cases they primarily need to add the same UEFI
> related information, so the function can be shared.  Create a new FDT
> related file for this to avoid use of architecture #ifdefs in
> efi-stub-helper.c.
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> [ Fixed memory node deletion code. ]
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> Acked-by: Grant Likely <grant.likely@linaro.org>
> ---
>  drivers/firmware/efi/fdt.c |  285 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/efi.h        |    3 +
>  2 files changed, 288 insertions(+)
>  create mode 100644 drivers/firmware/efi/fdt.c

Acked-by: Matt Fleming <matt.fleming@intel.com>

-- 
Matt Fleming, Intel Open Source Technology Center
