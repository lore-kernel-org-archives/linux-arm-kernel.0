From: robh@kernel.org (Rob Herring)
Date: Tue, 7 Aug 2018 12:00:59 -0600
Subject: [PATCH 1/2] arm64: dts: stratix10: Add Stratix10 SMMU support
In-Reply-To: <1532543077-8933-2-git-send-email-thor.thayer@linux.intel.com>
References: <1532543077-8933-1-git-send-email-thor.thayer@linux.intel.com>
 <1532543077-8933-2-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <20180807180059.GA4415@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 01:24:36PM -0500, thor.thayer at linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add SMMU support to the Stratix10 Device Tree which
> includes adding the SMMU node and adding IOMMU stream
> ids to the SMMU peripherals. Update bindings.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> This patch is dependent on the patch series
> "iommu/arm-smmu: Add runtime pm/sleep support"
> (https://patchwork.ozlabs.org/cover/946160/)

I don't think so.

> ---
>  .../devicetree/bindings/iommu/arm,smmu.txt         | 25 ++++++++++++++++++
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 30 ++++++++++++++++++++++
>  2 files changed, 55 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
