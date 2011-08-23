From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 23 Aug 2011 11:27:12 -0700
Subject: Tegra I2C driver compilation failure (was: RE: [PATCH] dt: add
	empty of_get_property for non-dt)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04AEA24F41@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF04A0687289@HQMAIL01.nvidia.com>
	<20110812004732.GF19115@trinity.fluff.org>
	<74CDBE0F657A3D45AFBB94109FB122FF04AEA24F41@HQMAIL01.nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B24A38CA@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Friday, August 12, 2011 3:09 PM:
...
> Related, here's the list of outstanding patches for i2c-tegra.c that I'm
> aware of:
> 
> [PATCH] i2c: Tegra: Add of_match_table
> http://www.spinics.net/lists/linux-i2c/msg05898.html
> 
> [PATCH] i2c: tegra: add I2C_FUNC_SMBUS_EMUL to adapter functionality
> http://www.spinics.net/lists/linux-i2c/msg05396.html
> 
> [PATCH] i2c: tegra: fix possible race condition after tx
> http://www.spinics.net/lists/linux-i2c/msg06103.html
> 
> Hope this helps! Thanks.

Ben,

I see the patches above aren't in linux-next yet. I'd love to get them
queued up so they get into 3.2. Can you please apply them? At least the
second of these was first posted over 4 months ago.

Thanks very much!

-- 
nvpublic
