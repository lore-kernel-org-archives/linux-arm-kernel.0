From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Apr 2016 18:58:55 +0200
Subject: [PATCH v3 0/5] arm64: tegra: fix DT definitions for GM20B GPU
In-Reply-To: <1459156984-32644-1-git-send-email-acourbot@nvidia.com>
References: <1459156984-32644-1-git-send-email-acourbot@nvidia.com>
Message-ID: <20160426165855.GA2388@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2016 at 06:22:59PM +0900, Alexandre Courbot wrote:
> Small series that fixes/completes DT bindings for Tegra GPUs and add two
> missing entries required for the Tegra210 GPU to operate properly.
> 
> Without these fixes, GM20B will crash during probe on 4.6 because a
> required clock is not activated.
> 
> Changes since v2:
> - Fixed device address in DT examples
> - Carried Acked-bys
> 
> Changes since v1:
> - Renamed "pllg_ref" clock to "ref" in DT bindings
> 
> Alexandre Courbot (5):
>   dt-bindings: gk20a: Fix typo in compatible name
>   dt-bindings: gk20a: Document iommus property
>   dt-bindings: Add documentation for GM20B GPU
>   arm64: tegra210: Add reference clock to GM20B
>   arm64: tegra210: Add IOMMU node to GM20B
> 
>  .../devicetree/bindings/gpu/nvidia,gk20a.txt       | 37 +++++++++++++++++++---
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  8 +++--
>  2 files changed, 38 insertions(+), 7 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160426/99377113/attachment.sig>
