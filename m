From: robh@kernel.org (Rob Herring)
Date: Fri, 20 Jul 2018 10:15:07 -0600
Subject: [PATCH 1/3] Docs: dt: arm-smmu: Add optional clock parameter
In-Reply-To: <1531499278-32132-2-git-send-email-thor.thayer@linux.intel.com>
References: <1531499278-32132-1-git-send-email-thor.thayer@linux.intel.com>
 <1531499278-32132-2-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <20180720161507.GA24992@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 11:27:56AM -0500, thor.thayer at linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add a clock to the SMMU node bindings.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 8a6ffce12af5..356fd9f41e1b 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -71,6 +71,8 @@ conditions.
>                    or using stream matching with #iommu-cells = <2>, and
>                    may be ignored if present in such cases.
>  
> +- clock:          clock provider specifier
> +

The TRM says there is a TCU clock and clock per TBU.

Rob
