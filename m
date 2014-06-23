From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 23 Jun 2014 12:53:16 +0200
Subject: [PATCH v3 09/10] ARM: update multi_v7_defconfig for STI
In-Reply-To: <1401899424-1365-10-git-send-email-peter.griffin@linaro.org>
References: <1401899424-1365-1-git-send-email-peter.griffin@linaro.org>
 <1401899424-1365-10-git-send-email-peter.griffin@linaro.org>
Message-ID: <53A8071C.8090309@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/04/2014 06:30 PM, Peter Griffin wrote:
> This patch enables SDHCI STI platform driver.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org> --- 
> arch/arm/configs/multi_v7_defconfig | 1 + 1 file changed, 1
> insertion(+)

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

> 
> diff --git a/arch/arm/configs/multi_v7_defconfig
> b/arch/arm/configs/multi_v7_defconfig index d4e8a47..48951fc
> 100644 --- a/arch/arm/configs/multi_v7_defconfig +++
> b/arch/arm/configs/multi_v7_defconfig @@ -277,6 +277,7 @@
> CONFIG_MMC_SDHCI_TEGRA=y CONFIG_MMC_SDHCI_DOVE=y 
> CONFIG_MMC_SDHCI_SPEAR=y CONFIG_MMC_SDHCI_BCM_KONA=y 
> +CONFIG_MMC_SDHCI_ST=y CONFIG_MMC_OMAP=y CONFIG_MMC_OMAP_HS=y 
> CONFIG_MMC_MVSDIO=y
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140623/76f01036/attachment.sig>
