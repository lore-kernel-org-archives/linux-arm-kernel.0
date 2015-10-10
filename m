From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Sat, 10 Oct 2015 23:31:36 +0100
Subject: [PATCH v4 1/3] arm64/efi: remove
 /chosen/linux,uefi-stub-kern-ver DT property
In-Reply-To: <1444330924-17830-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1444330924-17830-1-git-send-email-ard.biesheuvel@linaro.org>
 <1444330924-17830-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151010223136.GI2723@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 08 Oct, at 08:02:02PM, Ard Biesheuvel wrote:
> With the stub to kernel interface being promoted to a proper interface
> so that other agents than the stub can boot the kernel proper in EFI
> mode, we can remove the linux,uefi-stub-kern-ver field, considering
> that its original purpose was to prevent this from happening in the
> first place.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  Documentation/arm/uefi.txt         | 2 --
>  drivers/firmware/efi/libstub/fdt.c | 9 ---------
>  2 files changed, 11 deletions(-)

Good riddance ;-)

Reviewed-by: Matt Fleming <matt.fleming@intel.com>

-- 
Matt Fleming, Intel Open Source Technology Center
