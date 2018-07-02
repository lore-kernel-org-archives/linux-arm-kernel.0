From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 2 Jul 2018 15:56:51 +0200
Subject: [PATCH 4/5] arm64: tegra: Enable card detect for SD card on P2888
In-Reply-To: <20180620125406.11906-4-mperttunen@nvidia.com>
References: <20180620125406.11906-1-mperttunen@nvidia.com>
 <20180620125406.11906-4-mperttunen@nvidia.com>
Message-ID: <20180702135651.GK13096@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 03:54:05PM +0300, Mikko Perttunen wrote:
> Now that we have a GPIO controller, enable the card detect GPIO for
> the SD card slot.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180702/98b7e8b2/attachment.sig>
