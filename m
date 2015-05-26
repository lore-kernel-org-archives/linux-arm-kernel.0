From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Tue, 26 May 2015 19:15:58 +0100
Subject: [PATCH 4/8] efi: move FDT handling to separate object file
In-Reply-To: <1431326520-17331-5-git-send-email-ard.biesheuvel@linaro.org>
References: <1431326520-17331-1-git-send-email-ard.biesheuvel@linaro.org>
 <1431326520-17331-5-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150526181558.GB3030@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 May, at 08:41:56AM, Ard Biesheuvel wrote:
> The EFI specific FDT handling is compiled conditionally, and is
> logically independent of the rest of efi.o. So move it to a separate
> file before making changes to it in subsequent patches.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/Makefile  |  1 +
>  drivers/firmware/efi/efi-fdt.c | 93 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/firmware/efi/efi.c     | 86 --------------------------------------
>  3 files changed, 94 insertions(+), 86 deletions(-)
>  create mode 100644 drivers/firmware/efi/efi-fdt.c

Sorry for the delay,

Acked-by: Matt Fleming <matt.fleming@intel.com>

-- 
Matt Fleming, Intel Open Source Technology Center
