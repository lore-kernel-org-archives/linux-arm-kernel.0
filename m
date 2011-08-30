From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 30 Aug 2011 12:26:16 -0700
Subject: [PATCH 1/3] arm/dt: Tegra: Update SDHCI nodes to match bindings
In-Reply-To: <m2hb4yso44.fsf@bob.laptop.org>
References: <1314731837-6985-1-git-send-email-swarren@nvidia.com>
	<m2hb4yso44.fsf@bob.laptop.org>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B3279E01@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris Ball wrote at Tuesday, August 30, 2011 1:20 PM:
> Hi Stephen,
> 
> On Tue, Aug 30 2011, Stephen Warren wrote:
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > Acked-by: Olof Johansson <olof@lixom.net>
> > ---
> > This is a repost of http://www.spinics.net/lists/linux-tegra/msg02117.html
> > I'm including it here since it's not in linux-next yet, and patch 3 depends
> > on it.
> 
> I assume I should wait for patches 1+3 to appear in -next via another tree
> before I merge patch 2 -- let me know if that's incorrect.

I don't think there's actually any need for that; initializing Tegra's
SDHCI from device-tree has never worked in mainline to date; it relies
on patch 1 being there. And if patch 2 was there without patch 3,
the worst that will happen is some port runs in 4-bit mode instead of
8-bit, which evidently works fine since I didn't even notice 8-bit
support was missing...

Thanks for checking though.

-- 
nvpublic
