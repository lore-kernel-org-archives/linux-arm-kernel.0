From: robh@kernel.org (Rob Herring)
Date: Mon, 16 May 2016 11:44:14 -0500
Subject: [PATCH V4 2/7] documentation: iommu: Add bindings for
 msm,iommu-v0 ip
In-Reply-To: <1463381341-30498-3-git-send-email-sricharan@codeaurora.org>
References: <1463381341-30498-1-git-send-email-sricharan@codeaurora.org>
 <1463381341-30498-3-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160516164414.GA25899@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 12:18:56PM +0530, Sricharan R wrote:
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
> 
> diff --git a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> new file mode 100644
> index 0000000..b22c607
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> @@ -0,0 +1,64 @@
> +* QCOM IOMMU
> +
> +The MSM IOMMU is an implementation compatible with the ARM VMSA short
> +descriptor page tables. It provides address translation for bus masters outside
> +of the CPU, each connected to the IOMMU through a port called micro-TLB.
> +
> +Required Properties:
> +
> +  - compatible: Must contain "qcom,iommu-v0-apq8064".

qcom,apq8064-iommu would be the preferred order and I think you can drop 
the v0.
