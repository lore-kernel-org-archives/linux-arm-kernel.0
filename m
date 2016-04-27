From: edubezval@gmail.com (Eduardo Valentin)
Date: Wed, 27 Apr 2016 16:52:46 -0700
Subject: [PATCH 0/9] thermal: rockchip: Support rk3366/rk3399 SoCS and
 fixes the driver
In-Reply-To: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
References: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
Message-ID: <20160427235245.GC2590@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 11:35:52AM +0800, Caesar Wang wrote:
> Hello Eduardo, Heiko
> This series pacthes to support the rk3366/rk3399 SoCs thermal, and fixes the driver.
> 
> 65ae684 thermal: rockchip: disable thermal->clk in err case
> 31e6d69 thermal: rockchip: fixes the code_to_temp for tsadc driver
> 6e2d6fb thermal: rockchip: update the tsadc table for rk3399
> 49f6ccf thermal: rockchip: handle the power sequence for tsadc controller
> 9f8bd52 thermal: rockchip: Support RK3366 SoCs in the thermal driver
> a959e42 thermal: rockchip: add the notes for better reading

Applied patches 1-6. But please, consider sending a patch to use
usleep_range.

> e5cbc6a thermal: of: Add support for hardware-tracked trip points
> 7f613e4 thermal: rockchip: add the set_trips function
> 94cc571 arm64: dts: rockchip: move the rk3368 thermal data into rk3368.dtsi
> 

These patches, though, will need further discussion. I believe you would
probaly refresh them once we agree on Sascha's patchset.
