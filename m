From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Apr 2013 09:15:03 +0200
Subject: [RFC PATCH v2 11/13] ARM: mach-sunxi: cpus/cpu nodes dts updates
In-Reply-To: <1366644455-16550-12-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366644455-16550-12-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <51778677.908@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

Le 22/04/2013 17:27, Lorenzo Pieralisi a ?crit :
> This patch updates the in-kernel dts files according to the latest cpus
> and cpu bindings updates for ARM.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm/boot/dts/sunxi.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

Just to let you know, this file won't exist anymore in 3.10, and has
been split out in sun4i-a10.dtsi and sun5i-a13.dtsi. You'll obviously
need to change both when rebasing.

Other than that,
Acked-By: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
