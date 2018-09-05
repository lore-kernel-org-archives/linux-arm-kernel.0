From: olof@lixom.net (Olof Johansson)
Date: Wed, 5 Sep 2018 14:57:46 -0700
Subject: [PATCH] efi_stub: update documentation on dtb= parameter
In-Reply-To: <20180905190750.4566-1-grant.likely@arm.com>
References: <20180905190750.4566-1-grant.likely@arm.com>
Message-ID: <CAOesGMjzEKsa1rx-kHemcSyT2PudLeCd7OrogrVdn99efTXg8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 5, 2018 at 12:07 PM, Grant Likely <grant.likely@arm.com> wrote:
> The dtb= parameter is no longer the primary mechanism for providing a
> devicetree to the kernel. Now either firmware or the boot selector (ex.
> Grub) should provide the devicetree and dtb= should only be used for
> debug or when using firmware that doesn't understand DT.
> Update the EFI stub documentation to reflect the current usage.
>
> Signed-off-by: Grant Likely <grant.likely@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Jonathan Corbet <corbet@lwn.net>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
