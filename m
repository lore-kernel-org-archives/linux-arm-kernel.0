From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 14 Feb 2013 16:58:02 +0200
Subject: [PATCH 1/1] ARM: dt: add header to define tegra20 clocks
In-Reply-To: <20130214.154250.475978229890081002.hdoyu@nvidia.com>
References: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
 <1360823899-17846-1-git-send-email-hdoyu@nvidia.com>
 <20130214101220.GI3073@tbergstrom-lnx.Nvidia.com>
 <20130214.154250.475978229890081002.hdoyu@nvidia.com>
Message-ID: <20130214145802.GK3073@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> There could be the same kind of requirement from others that both
> "dtsip" and "C-source" want to share the same header file. If we
> consider that DT is the exact H/W description, C-source should be able
> to include a DT header file.
> 
> For example, a C-header file for "enum tegra{20,30}_clk" should be
> generated from "arch/arm/boot/dts/tegra{20,30}-car.h" at runtime, or
> alternatively just "drivers/clk/tegra/clk-tegra{20,30}.c" can include
> "arch/arm/boot/dts/tegra{20,30}-car.h"? The latter may be easier.

Including arch/arm/boot/dts/tegra{20,30}-car.h seems to make much more sense
to me than generating a enum based on #defines... :)

Cheers,

Peter.
