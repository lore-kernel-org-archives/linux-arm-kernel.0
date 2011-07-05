From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 5 Jul 2011 11:22:30 -0700
Subject: Tegra device name for device tree
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049E21BE97@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant et. al.,

It recently dawned on me that all the Tegra DeviceTree support is using a
marketing name for the SoC ("tegra250"). NVIDIA would prefer that we use
engineering names for the SoC (e.g. "tegra20" now, "tegra30" for an
upcoming SoC). The primary motivation for this is that engineering names
tend to be more stable and map more directly to the HW design.

Is it still possible to make this change, if I submit the appropriate
patches to do this? 

So, far, I see devicetree/next only refers to the Tegra serial port,
whereas devicetree/arm and devicetree/test refer to more Tegra devices in
this way. I'm not quite sure how the flow of patches works between these 3
trees. For the serial port, I obviously need to submit a patch against
devicetree/next, but I'm not so sure about which of devicetree/arm or
devicetree/test to target for the other devices.

Sorry for bringing this up so late in the game.

Thanks!

-- 
nvpublic
