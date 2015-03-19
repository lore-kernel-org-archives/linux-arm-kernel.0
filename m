From: pontus.fuchs@gmail.com (Pontus Fuchs)
Date: Thu, 19 Mar 2015 15:05:53 +0100
Subject: [PATCH v7 5/6] ARM: dts: add wl12xx/wl18xx bindings
In-Reply-To: <1426696710-6891-6-git-send-email-eliad@wizery.com>
References: <1426696710-6891-1-git-send-email-eliad@wizery.com>
 <1426696710-6891-6-git-send-email-eliad@wizery.com>
Message-ID: <550AD7C1.2030405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-03-18 17:38, Eliad Peller wrote:
> Replace all the pdata-quirks for setting wl12xx/wl18xx
> platform data with proper DT definitions.
>
> Signed-off-by: Eliad Peller <eliad@wizery.com>
> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
> Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> ---
> v7: rebase
>
>   arch/arm/boot/dts/am335x-evmsk.dts             | 11 ++++
>   arch/arm/boot/dts/omap3-cm-t3517.dts           | 10 ++++
>   arch/arm/boot/dts/omap3-cm-t3730.dts           | 10 ++++
>   arch/arm/boot/dts/omap3-evm-common.dtsi        | 10 ++++
>   arch/arm/boot/dts/omap3-igep0020-rev-f.dts     |  9 ++++
>   arch/arm/boot/dts/omap3-igep0030-rev-g.dts     |  9 ++++
>   arch/arm/boot/dts/omap3-zoom3.dts              | 10 ++++
>   arch/arm/boot/dts/omap4-panda-common.dtsi      | 10 ++++

Hi Eliad,

Tested OK (boot, scan, join, ping) on Pandaboard ES.

BR,

Pontus
