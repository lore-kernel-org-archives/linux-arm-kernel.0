From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 11:58:42 +0100
Subject: [PATCH v3 08/10] ARM: configs: add MPS2 defconfig
In-Reply-To: <1455617295-23736-9-git-send-email-vladimir.murzin@arm.com>
References: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>
 <1455617295-23736-9-git-send-email-vladimir.murzin@arm.com>
Message-ID: <2680417.bULLX3O66Y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 10:08:13 Vladimir Murzin wrote:
> This patch adds a new config for MPS2 platform.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/configs/mps2_defconfig |  112 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 arch/arm/configs/mps2_defconfig
> 
> diff --git a/arch/arm/configs/mps2_defconfig b/arch/arm/configs/mps2_defconfig
> new file mode 100644
> index 0000000..c36c519
> --- /dev/null
> +++ b/arch/arm/configs/mps2_defconfig
> @@ -0,0 +1,112 @@
> +# CONFIG_USELIB is not set
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_LOG_BUF_SHIFT=16
> +CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> +# CONFIG_UID16 is not set
> +# CONFIG_BASE_FULL is not set
> +# CONFIG_FUTEX is not set
> +# CONFIG_EPOLL is not set
> +# CONFIG_SIGNALFD is not set
> +# CONFIG_EVENTFD is not set
> +# CONFIG_AIO is not set
> +CONFIG_EMBEDDED=y

Why CONFIG_EMBEDDED? You probably mean CONFIG_EXPERT, but then what do
you need that for?

	Arnd
