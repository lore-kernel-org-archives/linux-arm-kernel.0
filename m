From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 7 Nov 2016 13:56:15 +0100
Subject: [PATCH V4 4/6] ARM: tegra: Add Tegra30 GMI support
In-Reply-To: <1478507405-13204-5-git-send-email-mirza.krak@gmail.com>
References: <1478507405-13204-1-git-send-email-mirza.krak@gmail.com>
 <1478507405-13204-5-git-send-email-mirza.krak@gmail.com>
Message-ID: <20161107125615.GA12559@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 09:30:03AM +0100, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
> 
> Add a device node for the GMI controller found on Tegra30.
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
> - no changes
> 
> Changes in v4:
> - no changes
> 
>  arch/arm/boot/dts/tegra30.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/5923a048/attachment.sig>
