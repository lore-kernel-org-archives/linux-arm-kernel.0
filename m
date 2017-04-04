From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 4 Apr 2017 16:01:58 +0200
Subject: [PATCH V3 5/6] arm64: tegra: Update the Tegra132 flowctrl
 compatible string
In-Reply-To: <1490704978-22906-6-git-send-email-jonathanh@nvidia.com>
References: <1490704978-22906-1-git-send-email-jonathanh@nvidia.com>
 <1490704978-22906-6-git-send-email-jonathanh@nvidia.com>
Message-ID: <20170404140158.GH843@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 01:42:57PM +0100, Jon Hunter wrote:
> Update the Tegra132 flowctrl compatible string to include
> "nvidia,tegra132-flowctrl" so it is aligned with the flowctrl binding
> documentation.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra132.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-4.12/arm64/dt, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170404/d2840e42/attachment.sig>
