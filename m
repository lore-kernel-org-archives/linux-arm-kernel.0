From: matt@console-pimps.org (Matt Fleming)
Date: Fri, 29 Nov 2013 10:36:49 +0000
Subject: [PATCH V5 1/6] efi-stub.txt updates for ARM
In-Reply-To: <1385595115-21488-2-git-send-email-roy.franz@linaro.org>
References: <1385595115-21488-1-git-send-email-roy.franz@linaro.org>
 <1385595115-21488-2-git-send-email-roy.franz@linaro.org>
Message-ID: <20131129103649.GA11775@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Nov, at 03:31:50PM, Roy Franz wrote:
> Update efi-stub.txt documentation to be more general
> and not x86 specific.  Add ARM only "dtb=" command
> line option description.
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> ---
>  Documentation/efi-stub.txt |   27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 

[...]

> -respectively.
> +respectively.  For ARM the EFI stub is implemented in
> +arch/arm/boot/compressed/efi-header.S and
> +arch/arm/boot/compressed/efi-stub.c.  EFI stub code that is shared
> +between architectures is in drivers/firmware/efi/efi-stub-helper.c.
  
No double spaces between full-stop and the beginning of a sentence
please. That convention isn't used anywhere else in this file.

> +For the ARM architecture, we also need to be able to provide a device
> +tree to the kernel.  This is done with the "dtb=" command line option,
> +and is process in the same manner as the "initrd=" option that is described

         ^^ processed ?

-- 
Matt Fleming, Intel Open Source Technology Center
