From: pratyush.anand@st.com (Pratyush Anand)
Date: Mon, 1 Jul 2013 15:27:41 +0530
Subject: [PATCH 2/4] ARM: Enable PCI Express on ARM
In-Reply-To: <1372662947-27160-3-git-send-email-xobs@kosagi.com>
References: <1372662947-27160-1-git-send-email-xobs@kosagi.com>
 <1372662947-27160-3-git-send-email-xobs@kosagi.com>
Message-ID: <51D15295.2000601@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/1/2013 12:45 PM, Sean Cross wrote:
> Some ARM devices have PCI Express hardware, and should be able to take
> advantage of PCI Express code present in the common driver files.  Enable
> PCI Express on ARM, when PCI is available.
>
> Signed-off-by: Sean Cross <xobs@kosagi.com>
> ---
>   arch/arm/Kconfig |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 136f263..2f51f13 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1418,6 +1418,8 @@ config PCI_HOST_ITE8152
>
>   source "drivers/pci/Kconfig"
>
> +source "drivers/pci/pcie/Kconfig"
> +
>

[PATCH V10 2/4] ARM: EXYNOS: Enable PCIe support for Exynos5440 does the 
same thing.

  source "drivers/pcmcia/Kconfig"
>
>   endmenu
>
