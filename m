From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 17 Jul 2015 10:03:14 +0200
Subject: [PATCH 0/4] ARM: tegra: enable Nouveau for Jetson TK1 and Venice 2
In-Reply-To: <1435742028-8237-1-git-send-email-acourbot@nvidia.com>
References: <1435742028-8237-1-git-send-email-acourbot@nvidia.com>
Message-ID: <20150717080313.GA3057@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 06:13:44PM +0900, Alexandre Courbot wrote:
> With all essential kernel driver and user-space patches merged, GK20A can now
> be enabled safely on Tegra124 devices. This series makes small device tree
> and configuration adjustments to allow this.
> 
> It leaves the GK20A nodes ready to be used, but still disabled. Enabling the
> nodes is the work of the bootloader, after it has configured VPR properly.
> 
> U-boot patches that do this are in the work. In the meantime, it is safe to
> merge this kernel support.
> 
> Alexandre Courbot (3):
>   ARM: tegra: Add IOMMU node to GK20A
>   ARM: tegra: jetson-tk1: Add GK20A GPU DT node
>   ARM: tegra: Enable Nouveau in defconfig
> 
> Thierry Reding (1):
>   ARM: tegra: venice2: Add GK20A GPU DT node
> 
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts | 10 +++++++++-
>  arch/arm/boot/dts/tegra124-venice2.dts    | 10 +++++++++-
>  arch/arm/boot/dts/tegra124.dtsi           |  3 +++
>  arch/arm/configs/tegra_defconfig          |  3 +++
>  4 files changed, 24 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150717/7c27f992/attachment-0001.sig>
