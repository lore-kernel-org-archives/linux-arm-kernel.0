From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 15:15:31 -0700
Subject: [PATCH v3 2/4] arm64: defconfig: enable ARCH_LG1K
In-Reply-To: <1460375687-2375-3-git-send-email-chanho.min@lge.com>
References: <1460375687-2375-1-git-send-email-chanho.min@lge.com>
 <1460375687-2375-3-git-send-email-chanho.min@lge.com>
Message-ID: <20160413221531.GB19945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 08:54:45PM +0900, Chanho Min wrote:
> Enable building LG1K support in the defconfig.
> 
> Signed-off-by: Chanho Min <chanho.min@lge.com>
> ---
> Changes for v2:
> 	- None
> Changes for v3:
> 	- None
> ---
>  arch/arm64/configs/defconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 86581f7..14dbe27 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -49,6 +49,7 @@ CONFIG_ARCH_UNIPHIER=y
>  CONFIG_ARCH_VEXPRESS=y
>  CONFIG_ARCH_XGENE=y
>  CONFIG_ARCH_ZYNQMP=y
> +CONFIG_ARCH_LG1K=y
>  CONFIG_PCI=y
>  CONFIG_PCI_MSI=y
>  CONFIG_PCI_IOV=y

Applied, again with inserting it in the right place (since it moves when the
Kconfig entry moves).


-Olof
