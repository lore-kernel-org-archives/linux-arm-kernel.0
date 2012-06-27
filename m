From: martinez.javier@gmail.com (Javier Martinez Canillas)
Date: Thu, 28 Jun 2012 00:28:03 +0200
Subject: [PATCH 1/1] ARM: OMAP: omap2plus_defconfig: Enable EXT4 support
In-Reply-To: <1340489939-5390-1-git-send-email-javier@dowhile0.org>
References: <1340489939-5390-1-git-send-email-javier@dowhile0.org>
Message-ID: <CAAwP0s2eTWk2Uf0HZ13Lq5gA0HNp8V87znjd6rX6Uh0ZPy03PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 24, 2012 at 12:18 AM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> On OMAP boards that includes an SD card slot, an EXT4 partition could
> be used to store the root file system. So, the kernel should have
> built-in support for EXT4 to be able to mount the VFS root on boot.
>
> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> ---
> ?arch/arm/configs/omap2plus_defconfig | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 9854ff4..f3087cb 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -197,6 +197,7 @@ CONFIG_RTC_DRV_TWL4030=y
> ?CONFIG_EXT2_FS=y
> ?CONFIG_EXT3_FS=y
> ?# CONFIG_EXT3_FS_XATTR is not set
> +CONFIG_EXT4_FS=y
> ?CONFIG_QUOTA=y
> ?CONFIG_QFMT_V2=y
> ?CONFIG_MSDOS_FS=y
> --
> 1.7.7.6
>

Hi,

any news about this patch?

Is quite annoying to have to enable EXT4 support each time I want to
try a new kernel on my board.

Best regards,
Javier
