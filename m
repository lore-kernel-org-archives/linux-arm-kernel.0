From: olof@lixom.net (Olof Johansson)
Date: Wed, 29 Aug 2018 11:44:58 -0700
Subject: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
In-Reply-To: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 29, 2018 at 10:21 AM, Scott Branden
<scott.branden@broadcom.com> wrote:
> Enable EFI_ARMSTUB_DTB_LOADER to add support for the dtb= command line
> parameter to function with efi loader.
>
> Required to boot on existing bootloaders that do not support devicetree
> provided by the platform or by the bootloader.
>
> Fixes: 3d7ee348aa41 ("efi/libstub/arm: Add opt-in Kconfig option for the DTB loader")
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Why did Ard create an option for this if it's just going be turned on
in default configs? Doesn't make sense to me.

It would help to know what firmware still is crippled and how common
it is, since it's been a few years that this has been a requirement by
now.


-Olof
