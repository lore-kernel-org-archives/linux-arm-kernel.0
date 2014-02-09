From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 09 Feb 2014 22:57:19 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxMi8yOF0gUmVtb3ZlIEdFTkVSSUNfVElNRQ==?=
In-Reply-To: <1391971686-9517-13-git-send-email-richard@nod.at>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
 <1391971686-9517-13-git-send-email-richard@nod.at>
Message-ID: <1391972239.567717844@f148.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The symbol is an orphan, get rid of it.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> arch/arm/mach-bcm/Kconfig | 1 -
> 1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index b1aa6a9..8dd5fbf 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -19,7 +19,6 @@ config ARCH_BCM_MOBILE
> select CPU_V7
> select CLKSRC_OF
> select GENERIC_CLOCKEVENTS
> -	select GENERIC_TIME
> select GPIO_BCM_KONA
> select SPARSE_IRQ
> select TICK_ONESHOT
> -- 
> 1.8.4.2

I sent a similar patch in November, maintainers nothing did with it.
http://permalink.gmane.org/gmane.linux.ports.arm.kernel/278293

---
