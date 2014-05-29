From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 29 May 2014 13:14:25 -0600
Subject: [PATCH v5 5/5] ARM: tegra: build new fuse driver in drivers/misc
In-Reply-To: <1401281677-32110-6-git-send-email-pdeschrijver@nvidia.com>
References: <1401281677-32110-1-git-send-email-pdeschrijver@nvidia.com>
 <1401281677-32110-6-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <53878711.9050702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2014 06:54 AM, Peter De Schrijver wrote:
> The Tegra fuse code has moved to drivers/misc/fuse/tegra. Enable the
> building of that code, and disable the building of the old fuse code in
> arch/arm/mach-tegra/.

> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 7eb4b69..994d02d 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -55,3 +55,5 @@ obj-$(CONFIG_SRAM)		+= sram.o
>  obj-y				+= mic/
>  obj-$(CONFIG_GENWQE)		+= genwqe/
>  obj-$(CONFIG_ECHO)		+= echo/
> +obj-y				+= fuse/
> +

This adds an empty blank line to the end of the file.
