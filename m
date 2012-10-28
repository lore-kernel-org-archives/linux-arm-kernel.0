From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 28 Oct 2012 15:43:33 +0400
Subject: [PATCH] arm: bcm2835: enable proc and sysfs in defconfig
In-Reply-To: <1351357249-17658-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351357249-17658-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <508D1A65.20506@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 27-10-2012 21:00, Thomas Petazzoni wrote:

> For some reason, support for proc and sysfs is currently disabled in
> the bcm2835_defconfig, even though those filesystems are quite
> essential even for very basic Linux userspace. As most defconfig have
> them enabled by default, enable them as well in bcm2835_defconfig.

> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>   arch/arm/configs/bcm2835_defconfig |    2 --
>   1 file changed, 2 deletions(-)

> diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
> index 7aea702..74e27f0 100644
> --- a/arch/arm/configs/bcm2835_defconfig
> +++ b/arch/arm/configs/bcm2835_defconfig
> @@ -66,8 +66,6 @@ CONFIG_TTY_PRINTK=y
>   # CONFIG_FILE_LOCKING is not set
>   # CONFIG_DNOTIFY is not set
>   # CONFIG_INOTIFY_USER is not set
> -# CONFIG_PROC_FS is not set
> -# CONFIG_SYSFS is not set

    Hm, I don't see where are you enabling them... So I miss something?

WBR, Sergei
