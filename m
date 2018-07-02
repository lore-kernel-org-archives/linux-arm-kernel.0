From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 2 Jul 2018 15:57:54 +0200
Subject: [PATCH v2 2/2] arm64: tegra: Add CPU nodes to Tegra194 device tree
In-Reply-To: <20180702121131.13461-2-mperttunen@nvidia.com>
References: <20180702121131.13461-1-mperttunen@nvidia.com>
 <20180702121131.13461-2-mperttunen@nvidia.com>
Message-ID: <20180702135754.GM13096@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 03:11:31PM +0300, Mikko Perttunen wrote:
> Add CPU and PSCI nodes to device tree. The Tegra194 SoC contains
> eight NVIDIA Carmel CPUs.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     - Moved PSCI node/properties to SoC device tree
> 
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 67 ++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180702/52fafbe9/attachment.sig>
