From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 7 Nov 2016 12:28:09 +0100
Subject: [PATCH V4 2/6] clk: tegra: add TEGRA30_CLK_NOR to init table
In-Reply-To: <1478507405-13204-3-git-send-email-mirza.krak@gmail.com>
References: <1478507405-13204-1-git-send-email-mirza.krak@gmail.com>
 <1478507405-13204-3-git-send-email-mirza.krak@gmail.com>
Message-ID: <20161107112809.GB28616@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 09:30:01AM +0100, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
> 
> Add TEGRA30_CLK_NOR to init table and set default rate to 127 MHz which
> is max rate.
> 
> The maximum rate value of 127 MHz is pulled from the downstream L4T
> kernel.
> 
> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Tested-on: Colibri T20/T30 on EvalBoard V3.x and GMI-Memory Board
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> 
> Changes in v2:
> - no changes
> 
> Changes in v3:
> - Added comment in commit message where I got the maximum rates from.
> 
> Changes in V4:
> - no changes
> 
>  drivers/clk/tegra/clk-tegra30.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/c0620109/attachment-0001.sig>
