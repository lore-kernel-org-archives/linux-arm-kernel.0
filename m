From: corbet@lwn.net (Jonathan Corbet)
Date: Sun, 9 Sep 2018 14:47:11 -0600
Subject: [PATCH RESEND] efi_stub: update documentation on dtb= parameter
In-Reply-To: <20180906182927.22318-1-grant.likely@arm.com>
References: <20180906182927.22318-1-grant.likely@arm.com>
Message-ID: <20180909144711.12261570@lwn.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  6 Sep 2018 19:29:27 +0100
Grant Likely <grant.likely@arm.com> wrote:

> The dtb= parameter is no longer the primary mechanism for providing a
> devicetree to the kernel. Now either firmware or the boot selector (ex.
> Grub) should provide the devicetree and dtb= should only be used for
> debug or when using firmware that doesn't understand DT.
> Update the EFI stub documentation to reflect the current usage.
> 
> Signed-off-by: Grant Likely <grant.likely@arm.com>
> Reviewed-by: Alexander Graf <agraf@suse.de>
> Acked-by: Leif Lindholm <leif.lindholm@linaro.org>
> Acked-by: Olof Johansson <olof@lixom.net>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied, thanks.

jon
