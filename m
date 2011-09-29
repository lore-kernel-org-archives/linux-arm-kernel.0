From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Sep 2011 10:29:51 +0100
Subject: [PATCH v5 2/3] arm/tegra: add support for ventana pinmuxing
In-Reply-To: <1317248978-10829-3-git-send-email-pdeschrijver@nvidia.com>
References: <1317248978-10829-1-git-send-email-pdeschrijver@nvidia.com>
	<1317248978-10829-3-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20110929092951.GE23944@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 01:29:35AM +0300, Peter De Schrijver wrote:
> diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
> index f11b910..91a07e1 100644
> --- a/arch/arm/mach-tegra/Makefile
> +++ b/arch/arm/mach-tegra/Makefile
> @@ -31,6 +31,7 @@ obj-${CONFIG_MACH_SEABOARD}             += board-seaboard-pinmux.o
>  
>  obj-${CONFIG_MACH_TEGRA_DT}             += board-dt.o
>  obj-${CONFIG_MACH_TEGRA_DT}             += board-harmony-pinmux.o
> +obj-${CONFIG_MACH_TEGRA_DT}             += board-seaboard-pinmux.o

Since when did Tegra start using braces instead of parens in its Makefile?
I note some of Tegra's makefile is using braces and some of it parens.
What's the reason for this alternative style to the rest of kbuild?
