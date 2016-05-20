From: scott.branden@broadcom.com (Scott Branden)
Date: Fri, 20 May 2016 13:36:45 -0700
Subject: [PATCH 0/7] ARM: multi_v7_defconfig: Add more Broadcom SoCs
In-Reply-To: <1463771252-12805-1-git-send-email-f.fainelli@gmail.com>
References: <1463771252-12805-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <573F755D.3070203@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On 16-05-20 12:07 PM, Florian Fainelli wrote:
> This patch series enables more fundamental drivers which are useful for
> Broadcom BCM63xx and BCM7xxx SoCs.
>
> The last patch remove bcm_defconfig which is causing a whole lot of confusiong
> at best and is completely out of sync now.
>
> Florian Fainelli (7):
>    ARM: multi_v7_defconfig: Enable BCM63xx
>    ARM: multi_v7_defconfig: Enable BRCMSTB networking
>    ARM: multi_v7_defconfig: Enable BRCMSTB AHCI
>    ARM: multi_v7_defconfig: Enable BCM7038 Watchdog
>    ARM: multi_v7_defconfig: Enable Broadcom STB PWM
>    ARM: multi_v7_defconfig: Enable Broadcom Kona watchdog
>    ARM: Remove bcm_defconfig

Patch series looks good.  Given we can't upstream a defconfig per SoC 
family, bcm_defconfig is quite useless and can be removed.

Acked-by: Scott Branden <scott.branden@broadcom.com>
>
>   arch/arm/configs/bcm_defconfig      | 142 ------------------------------------
>   arch/arm/configs/multi_v7_defconfig |  13 ++++
>   2 files changed, 13 insertions(+), 142 deletions(-)
>   delete mode 100644 arch/arm/configs/bcm_defconfig
>
