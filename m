From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Apr 2018 12:20:16 -0500
Subject: [PATCH 1/6 v3] Docs: dt: add fsl-mc iommu-map device-tree binding
In-Reply-To: <1524824826-29473-2-git-send-email-nipun.gupta@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1524824826-29473-2-git-send-email-nipun.gupta@nxp.com>
Message-ID: <20180427172016.phpsjiique25impv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 03:57:01PM +0530, Nipun Gupta wrote:
> The existing IOMMU bindings cannot be used to specify the relationship
> between fsl-mc devices and IOMMUs. This patch adds a generic binding for
> mapping fsl-mc devices to IOMMUs, using iommu-map property.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>  .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
