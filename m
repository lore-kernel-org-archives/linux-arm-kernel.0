From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 19 Oct 2014 11:12:45 +0800
Subject: [PATCH 05/12] soc/tegra: Add efuse driver for Tegra
In-Reply-To: <1405080971-7609-6-git-send-email-thierry.reding@gmail.com>
References: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
 <1405080971-7609-6-git-send-email-thierry.reding@gmail.com>
Message-ID: <20141019031241.GA18880@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 02:16:04PM +0200, Thierry Reding wrote:
> diff --git a/drivers/misc/fuse/Makefile b/drivers/misc/fuse/Makefile
> new file mode 100644
> index 000000000000..0679c4febc89
> --- /dev/null
> +++ b/drivers/misc/fuse/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_ARCH_TEGRA)	+= tegra/

I just happened to notice this change on linux-next introduced by this
patch?  It's a leftover from early version of the patch, I guess?

Shawn
