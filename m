From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Sun, 16 Nov 2014 11:45:04 +0100
Subject: [PATCH] ARM: dts: sunxi: Add de_be0 clk parent pll to simplefb
 node
In-Reply-To: <1416133347-10459-1-git-send-email-hdegoede@redhat.com>
References: <1416133347-10459-1-git-send-email-hdegoede@redhat.com>
Message-ID: <54688030.40202@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 16.11.2014 um 11:22 schrieb Hans de Goede:
> Avoid the parent pll for the mod-clk for de_be0 getting disabled when non of

"none"

> the other users are enabled (which can happens on boards when non of i2c, spi

"can happen", "none"

> and mmc are in use).
> 
> Note for now we point directly to the parent rather then to the de_be0 mod-clk

"than"

> as that is not modelled in our devicetree yet.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi  | 3 ++-
>  arch/arm/boot/dts/sun5i-a10s.dtsi | 3 ++-
>  arch/arm/boot/dts/sun6i-a31.dtsi  | 1 +
>  arch/arm/boot/dts/sun7i-a20.dtsi  | 3 ++-
>  4 files changed, 7 insertions(+), 3 deletions(-)

Patch itself looks okay. Maybe Maxime can fix up when applying.

Cheers,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg
