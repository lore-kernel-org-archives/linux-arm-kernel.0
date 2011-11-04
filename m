From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 4 Nov 2011 08:27:21 -0700
Subject: [PATCH 1/2] arm/dt: add basic usb nodes to tegra device trees
In-Reply-To: <1320377174-28047-1-git-send-email-olof@lixom.net>
References: <1320377174-28047-1-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173F9A4CAC@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Thursday, November 03, 2011 9:26 PM:
> For now they are a minimal binding. It needs to be amended with
> vendor-specific settings for phy setup and link tuning, etc.
...
> diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
...
> +	usb at c5000000 {
> +		nvidia,vbus-gpio = <&gpio 24 0>; /* PD0 */
> +	};

Given that's a custom property, don't we need bindings documentation in
Documentation/devictree/bindings/usb/? Even if the binding is pretty self-
explanatory.

-- 
nvpublic
