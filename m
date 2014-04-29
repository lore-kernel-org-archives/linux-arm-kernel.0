From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 29 Apr 2014 12:28:49 +0100
Subject: [PATCH v2 10/10] efi/arm64: ignore dtb= when UEFI SecureBoot is
 enabled
In-Reply-To: <1398442154-19974-11-git-send-email-leif.lindholm@linaro.org>
References: <1398442154-19974-1-git-send-email-leif.lindholm@linaro.org>
 <1398442154-19974-11-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20140429112849.GJ26088@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Apr, at 05:09:14PM, Leif Lindholm wrote:
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> Loading unauthenticated FDT blobs directly from storage is a security hazard,
> so this should only be allowed when running with UEFI Secure Boot disabled.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>  drivers/firmware/efi/arm-stub.c |   39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)

Acked-by: Matt Fleming <matt.fleming@intel.com>

-- 
Matt Fleming, Intel Open Source Technology Center
