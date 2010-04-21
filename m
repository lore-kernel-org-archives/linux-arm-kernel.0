From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 22 Apr 2010 06:10:59 +0800
Subject: [PATCH 1/2] SA1100: fix wrong CPU type for h3100 and h3600
In-Reply-To: <1271875749-2891-2-git-send-email-mad_soft@inbox.ru>
References: <1271875749-2891-1-git-send-email-mad_soft@inbox.ru>
	<1271875749-2891-2-git-send-email-mad_soft@inbox.ru>
Message-ID: <j2nf17812d71004211510kbdb8c3c6j731f07e774c2c95c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 22, 2010 at 2:49 AM, Dmitry Artamonow <mad_soft@inbox.ru> wrote:
> They have StrongARM SA1110, not SA1100.
>
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>

Looks correct to me.

> ---
> ?arch/arm/mach-sa1100/Kconfig | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
> index b17d52f..fd4c52b 100644
> --- a/arch/arm/mach-sa1100/Kconfig
> +++ b/arch/arm/mach-sa1100/Kconfig
> @@ -57,7 +57,7 @@ config SA1100_COLLIE
> ?config SA1100_H3100
> ? ? ? ?bool "Compaq iPAQ H3100"
> ? ? ? ?select HTC_EGPIO
> - ? ? ? select CPU_FREQ_SA1100
> + ? ? ? select CPU_FREQ_SA1110
> ? ? ? ?help
> ? ? ? ? ?Say Y here if you intend to run this kernel on the Compaq iPAQ
> ? ? ? ? ?H3100 handheld computer. ?Information about this machine and the
> @@ -68,7 +68,7 @@ config SA1100_H3100
> ?config SA1100_H3600
> ? ? ? ?bool "Compaq iPAQ H3600/H3700"
> ? ? ? ?select HTC_EGPIO
> - ? ? ? select CPU_FREQ_SA1100
> + ? ? ? select CPU_FREQ_SA1110
> ? ? ? ?help
> ? ? ? ? ?Say Y here if you intend to run this kernel on the Compaq iPAQ
> ? ? ? ? ?H3600 handheld computer. ?Information about this machine and the
> --
> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
