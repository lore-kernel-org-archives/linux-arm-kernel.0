From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 3 Jan 2012 15:03:30 -0800
Subject: [PATCH v1 0/3] Tegra30 clockframework
In-Reply-To: <1325517486-22458-1-git-send-email-pdeschrijver@nvidia.com>
References: <1325517486-22458-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17761F1220@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Monday, January 02, 2012 8:18 AM:
> This patchset introduces the tegra30 clockframework. Clocks which require
> voltage scaling are not included in this version. The implementation doesn't
> use the generic clock code yet. It's the intention to move to it, once the
> semantics are fully clarified.

I'm not particularly familiar with Tegra's clocks, but nothing really
stood out as wrong with this patch on a quick look-through. It'd be great
if someone like Colin could look this over.

A couple thoughts below. You've probably thought about some of these
already, but I just wanted to make sure:-)

* Are we following the common clock stuff so we can move over once it's
ready?

* Are Tegra20 and Tegra30 so different we can't re-use any of the code
in tegra2_clocks.c for Tegra30?

* The device names in the peripheral clock table might benefit from a
review to make sure they match tegra2_clocks.c for the drivers we've
actually upstreamed at least.

-- 
nvpublic
