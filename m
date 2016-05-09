From: will.deacon@arm.com (Will Deacon)
Date: Mon, 9 May 2016 10:09:52 +0100
Subject: Reverting ARCH_SUNXI arm64 support(?)
In-Reply-To: <57304FF7.3080909@arm.com>
References: <57304FF7.3080909@arm.com>
Message-ID: <20160509090951.GC19763@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 09:53:11AM +0100, Andre Przywara wrote:
> Hi Will, Catalin,

Hi Andre,

> Suzuki reported a build failure with certain (non-defconfig) .configs
> due to the new ARCH_SUNXI support in 4.6-rc [1].
> As unfortunately we couldn't agree on a solution and also the support
> for the A64/Pine64 is partial in 4.6 anyway, can you please revert:
> ce3dd55b99b151a90ac1701c6825f2ae2d49b54e ("arm64: Introduce Allwinner
> SoC config option")

Given that we (Catalin and I) didn't commit that patch, it seems weird
that we should be reverting it. Shouldn't this be handled in arm-soc or
via the sunxi subtree?

We're also a week from the merge window, so it doesn't seem like a good
time to be hacking at .config/kconfig-related issues.

Will
