From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 7 Nov 2016 13:56:32 +0100
Subject: [PATCH V4 5/6] ARM: tegra: Add Tegra20 GMI support
In-Reply-To: <1478507405-13204-6-git-send-email-mirza.krak@gmail.com>
References: <1478507405-13204-1-git-send-email-mirza.krak@gmail.com>
 <1478507405-13204-6-git-send-email-mirza.krak@gmail.com>
Message-ID: <20161107125632.GB12559@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 09:30:04AM +0100, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
> 
> Add a device node for the GMI controller found on Tegra20.
> 
> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Tested-on: Colibri T20/T30 on EvalBoard V3.x and GMI-Memory Board
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> 
> Changes in v2:
> - added address-cells, size-cells and ranges properties
> 
> Changes in v3:
> - fixed range address which is not the same as Tegra30.
> 
> Changes in v4:
> - removed extra newline and a initial space in resets property.
> 
>  arch/arm/boot/dts/tegra20.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/f7d7603a/attachment.sig>
