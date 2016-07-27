From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 27 Jul 2016 17:57:45 +0200
Subject: [PATCH 01/18] ARM: mvebu: enable MTD command line partition table
 in mvebu_v7_defconfig
In-Reply-To: <1469105055-25181-2-git-send-email-jaz@semihalf.com> (Grzegorz
 Jaszczyk's message of "Thu, 21 Jul 2016 14:43:57 +0200")
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-2-git-send-email-jaz@semihalf.com>
Message-ID: <87wpk7m5ty.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grzegorz,
 
 On jeu., juil. 21 2016, Grzegorz Jaszczyk <jaz@semihalf.com> wrote:

> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>

As pointed by Andrew a commit log entry would be nice. Except this:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


> ---
>  arch/arm/configs/mvebu_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
> index 486a4ca..f43a7aa 100644
> --- a/arch/arm/configs/mvebu_v7_defconfig
> +++ b/arch/arm/configs/mvebu_v7_defconfig
> @@ -48,6 +48,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_MTD=y
> +CONFIG_MTD_CMDLINE_PARTS=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_CFI=y
>  CONFIG_MTD_CFI_INTELEXT=y
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
