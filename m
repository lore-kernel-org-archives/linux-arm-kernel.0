From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Wed, 2 Mar 2016 12:22:48 +0000
Subject: [PATCH 3/5] efi: add support for the EFI_MEMORY_ATTRIBUTES_TABLE
 config table
In-Reply-To: <1456151158-25849-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1456151158-25849-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456151158-25849-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160302122248.GE2649@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Feb, at 03:25:56PM, Ard Biesheuvel wrote:
> This declares the GUID and struct typedef for the new memory attributes
> table which contains the permissions that can be used to apply stricter
> permissions to UEFI Runtime Services memory regions.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/efi.c |  2 ++
>  include/linux/efi.h        | 13 +++++++++++++
>  2 files changed, 15 insertions(+)

Looks good Ard.
