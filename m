From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 29 Feb 2016 07:54:24 +0100
Subject: [PATCH V3] ARM64: tegra: Add support for Google Pixel C
In-Reply-To: <1455020809-17531-1-git-send-email-jonathanh@nvidia.com>
References: <1454949199-27050-1-git-send-email-jonathanh@nvidia.com>
 <1455020809-17531-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <20160229065424.GD23745@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 12:26:49PM +0000, Jon Hunter wrote:
> Add initial device-tree support for Google Pixel C (a.k.a. Smaug) based
> upon Tegra210 SoC with 3 GiB of LPDDR4 RAM.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> 
> Changes v2 -> v3:
> - Added PSCI information to enable all 4 CPUs on boot
> 
> Changes v1 -> v2:
> - Removed console boot parameter and added stdout-path
> - Added 32k clock for PMC
> 
>  arch/arm64/boot/dts/nvidia/Makefile           |  1 +
>  arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 83 +++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160229/5c33bdce/attachment.sig>
