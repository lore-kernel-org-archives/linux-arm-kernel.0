From: robh@kernel.org (Rob Herring)
Date: Mon, 23 May 2016 16:23:13 -0500
Subject: [PATCH V5 2/7] documentation: iommu: Add bindings for
 msm,iommu-v0 ip
In-Reply-To: <1463741694-1735-3-git-send-email-sricharan@codeaurora.org>
References: <1463741694-1735-1-git-send-email-sricharan@codeaurora.org>
 <1463741694-1735-3-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160523212313.GA4647@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2016 at 04:24:49PM +0530, Sricharan R wrote:
> The MSM IOMMU is an implementation compatible with the ARM VMSA short
> descriptor page tables. It provides address translation for bus masters outside
> of the CPU, each connected to the IOMMU through a port called micro-TLB.
> Adding the DT bindings for the same.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  .../devicetree/bindings/iommu/msm,iommu-v0.txt     | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt

Acked-by: Rob Herring <robh@kernel.org>
