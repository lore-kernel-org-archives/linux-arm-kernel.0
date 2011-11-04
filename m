From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 4 Nov 2011 14:20:05 -0400
Subject: [PATCH 1/2] arm/dt: add basic usb nodes to tegra device trees
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173F9A4CAC@HQMAIL01.nvidia.com>
References: <1320377174-28047-1-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF173F9A4CAC@HQMAIL01.nvidia.com>
Message-ID: <CACxGe6u5UJLwE+-iS_GzQxE5wkJ1RH_c9MFdrHfa__Wju-SuHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 4, 2011 at 11:27 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Thursday, November 03, 2011 9:26 PM:
>> For now they are a minimal binding. It needs to be amended with
>> vendor-specific settings for phy setup and link tuning, etc.
> ...
>> diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
> ...
>> + ? ? usb at c5000000 {
>> + ? ? ? ? ? ? nvidia,vbus-gpio = <&gpio 24 0>; /* PD0 */
>> + ? ? };
>
> Given that's a custom property, don't we need bindings documentation in
> Documentation/devictree/bindings/usb/? Even if the binding is pretty self-
> explanatory.

Yes, you're right.  Please add a binding, but you can leave my ack in
place when reposted.

g.
