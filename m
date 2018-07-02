From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 2 Jul 2018 15:57:03 +0200
Subject: [PATCH 5/5] arm64: tegra: Add ethernet controller on Tegra194
In-Reply-To: <20180620125406.11906-5-mperttunen@nvidia.com>
References: <20180620125406.11906-1-mperttunen@nvidia.com>
 <20180620125406.11906-5-mperttunen@nvidia.com>
Message-ID: <20180702135703.GL13096@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 03:54:06PM +0300, Mikko Perttunen wrote:
> The Tegra194 contains the same ethernet controller as the Tegra186.
> Add the device tree node for it, and correspondingly the PHY node
> on the board device tree.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 20 ++++++++++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 22 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180702/d0df3522/attachment.sig>
