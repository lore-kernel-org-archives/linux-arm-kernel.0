From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Wed, 7 Nov 2018 21:39:26 +0100
Subject: [PATCH 0/9] Regenerate arm64 defconfig for current kernel
In-Reply-To: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
Message-ID: <6eb79d2e-1857-39b5-90f5-29bc13bce16a@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

The following patch series was sent to arm at kernel.org
but the messages bounced because the SMTP server is
currently blacklisted. Can you get the patches through
the LAKML mailing list?

Regards.

On 07/11/2018 21:12, Marc Gonzalez wrote:

> Hello ARM maintainers,
> 
> The set of Kconfig options slowly changes with every kernel version.
> This patch series regenerates the arm64 defconfig for v4.20
> No functional change intended, except adding PINCTRL_MTK_MOORE to
> keep PINCTRL_MT7622.
> 
> Marc Gonzalez (9):
>   arm64: defconfig: Regenerate for v4.20
>   arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
>   arm64: defconfig: Drop NF_CONNTRACK_IPV{4,6}
>   arm64: defconfig: Drop USB_ULPI_BUS and USB_CHIPIDEA_ULPI
>   arm64: defconfig: Replace PINCTRL_MT7622 with PINCTRL_MTK_MOORE
>   arm64: defconfig: Drop redundant SND_SOC_ROCKCHIP_I2S
>   arm64: defconfig: Drop CRYPTO_DEV_FSL_DPAA2_CAAM
>   arm64: defconfig: Change SCSI_UFS_HISI=m
>   arm64: defconfig: Drop redundant sound codec options
> 
>  arch/arm64/configs/defconfig | 105 +++++++++++++++--------------------
>  1 file changed, 46 insertions(+), 59 deletions(-)
