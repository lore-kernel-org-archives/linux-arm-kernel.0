From: l.majewski@samsung.com (Lukasz Majewski)
Date: Mon, 08 Jun 2015 17:10:37 +0200
Subject: [PATCHv2 1/2] ARM: exynos_defconfig: Enable
 CONFIG_SND_SOC_ODROIDX2 for Odroid-XU3
In-Reply-To: <1433696621-4763-1-git-send-email-linux.amoon@gmail.com>
References: <1433696621-4763-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <20150608171037.70ca6796@amdc2363>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anand,

> Enable CONFIG_SND_SOC_ODROIDX2 and CONFIG_SND_SIMPLE_CARD to enable
> sound on Odroid-XU3 board.
> 
> Below is the output of boot log.
> [    6.021550] max98090 5-0010: MAX98090 REVID=0x43
> [    6.025506] random: nonblocking pool is initialized
> [    6.047297] asoc-simple-card sound: HiFi <-> 3830000.i2s mapping ok
> [    6.068392] s5m-rtc s2mps14-rtc: setting system clock to
> 2015-06-07 12:51:06 UTC (1433681466) [    6.123650] ALSA device list:
> [    6.135203]   #0: Odroid-XU3
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/configs/exynos_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig
> b/arch/arm/configs/exynos_defconfig index 9504e77..1b7253b 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -144,6 +144,8 @@ CONFIG_SND=y
>  CONFIG_SND_SOC=y
>  CONFIG_SND_SOC_SAMSUNG=y
>  CONFIG_SND_SOC_SNOW=y
> +CONFIG_SND_SOC_ODROIDX2=y
> +CONFIG_SND_SIMPLE_CARD=y
>  CONFIG_USB=y
>  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>  CONFIG_USB_XHCI_HCD=y

Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
