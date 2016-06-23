From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 22 Jun 2016 17:55:09 -0700
Subject: [PATCH 0/3] hw_random: bcm2835: Add support for Broadcom BCM5301x
In-Reply-To: <1466641623-3491-1-git-send-email-f.fainelli@gmail.com>
References: <1466641623-3491-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <576B336D.1000308@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch series looks good.

Acked-by: Scott Branden <scott.branden@broadcom.com>

On 16-06-22 05:27 PM, Florian Fainelli wrote:
> Hi all,
>
> This patch series adds support for the Broadcom BCM5301x SoCs random number
> generator which is the same block as the one found in NSP and BCM2835.
>
> Florian Fainelli (3):
>    Documentation: devicetree: bindings: Add BCM5301x binding
>    hw_random: bcm2835: Add support for Broadcom BCM5301x
>    ARM: dts: BCM5301x: Add RNG Device Tree node
>
>   Documentation/devicetree/bindings/rng/brcm,bcm2835.txt | 3 ++-
>   arch/arm/boot/dts/bcm5301x.dtsi                        | 5 +++++
>   drivers/char/hw_random/Kconfig                         | 2 +-
>   drivers/char/hw_random/bcm2835-rng.c                   | 1 +
>   4 files changed, 9 insertions(+), 2 deletions(-)
>
