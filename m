From: cjb@laptop.org (Chris Ball)
Date: Tue, 30 Aug 2011 15:31:28 -0400
Subject: [PATCH 1/3] arm/dt: Tegra: Update SDHCI nodes to match bindings
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B3279E01@HQMAIL01.nvidia.com>
	(Stephen Warren's message of "Tue, 30 Aug 2011 12:26:16 -0700")
References: <1314731837-6985-1-git-send-email-swarren@nvidia.com>
	<m2hb4yso44.fsf@bob.laptop.org>
	<74CDBE0F657A3D45AFBB94109FB122FF04B3279E01@HQMAIL01.nvidia.com>
Message-ID: <m2d3fmsnlb.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 30 2011, Stephen Warren wrote:
> I don't think there's actually any need for that; initializing Tegra's
> SDHCI from device-tree has never worked in mainline to date; it relies
> on patch 1 being there. And if patch 2 was there without patch 3,
> the worst that will happen is some port runs in 4-bit mode instead of
> 8-bit, which evidently works fine since I didn't even notice 8-bit
> support was missing...

Ah, okay.  I've merged patch 2 to mmc-next for 3.2, then, and will keep
an eye on what happens with the arch patches.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
