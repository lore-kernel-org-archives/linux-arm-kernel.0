From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 Mar 2012 14:25:21 -0800
Subject: [PATCH] ARM: tegra: update defconfig
In-Reply-To: <1330983838-25327-1-git-send-email-swarren@nvidia.com>
References: <1330983838-25327-1-git-send-email-swarren@nvidia.com>
Message-ID: <20120305222521.GA30240@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 02:43:58PM -0700, Stephen Warren wrote:
> Refresh tegra_defconfig:
> 
> New options enabled:
> * PERF_EVENTS
> * Tegra EMC scaling
> * Support for all 4 CPUs on Tegra30
> * AUTO_ZRELADDR for unified Tegra20+Tegra30 images
> * CPU_FREQ/CPU_IDLE
> * BLK_DEV_SR
> * INPUT_EVDEV
> * Regulators, including fixed, GPIO, TPS6586x
> * Audio for Tegra+ALC5632 (for Paz00/Toshiba AC100)
> * NVEC (staging, for Paz00/Toshiba AC100)
> * IOMMU for Tegra20's GART and Tegra30's SMMU
> * TEGRA_AES
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This is slightly late for 3.4, but hopefully can just squeak in.

Yeah, timing is OK for this, no worries.

I was planning on doing one patch as well, since I want to turn on EXT4 (for
eMMC/SD it's a good idea to use trim). Care to do that in your patch instead so
we only have one update?


Thanks,

-Olof
