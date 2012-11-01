From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 1 Nov 2012 10:34:12 -0400 (EDT)
Subject: [PATCH 1/6] arch: Change defconfigs to point to g_mass_storage.
In-Reply-To: <46dde680f525562e9fd19567deb5247f0bf26842.1351715302.git.mina86@mina86.com>
Message-ID: <Pine.LNX.4.44L0.1211011033170.1762-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Oct 2012, Michal Nazarewicz wrote:

> From: Michal Nazarewicz <mina86@mina86.com>
> 
> The File-backed Storage Gadget (g_file_storage) is being removed, since
> it has been replaced by Mass Storage Gadget (g_mass_storage).  This commit
> changes defconfigs point to the new gadget.

...

> --- a/arch/arm/configs/qil-a9260_defconfig
> +++ b/arch/arm/configs/qil-a9260_defconfig
> @@ -108,7 +108,6 @@ CONFIG_ROOT_NFS=y
>  CONFIG_NLS_CODEPAGE_437=y
>  CONFIG_NLS_CODEPAGE_850=y
>  CONFIG_NLS_ISO8859_1=y
> -CONFIG_DEBUG_KERNEL=y
>  CONFIG_DEBUG_USER=y
>  CONFIG_DEBUG_LL=y
>  # CONFIG_CRYPTO_HW is not set

This seems to have crept in by mistake.

Alan Stern
