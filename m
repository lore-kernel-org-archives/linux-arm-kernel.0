From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 2 Feb 2016 15:37:02 +0100
Subject: [PATCH V5 12/14] clk: tegra210: Add the APB2APE audio clock
In-Reply-To: <1453998832-27383-13-git-send-email-jonathanh@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
 <1453998832-27383-13-git-send-email-jonathanh@nvidia.com>
Message-ID: <20160202143702.GA10098@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 04:33:50PM +0000, Jon Hunter wrote:
> The APB2APE clock for the audio subsystem is required for powering up the
> audio power domain and accessing the various modules in this subsystem on
> the tegra210 device. Add this clock for tegra210.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/clk/tegra/clk-id.h               | 1 +
>  drivers/clk/tegra/clk-tegra-periph.c     | 1 +
>  drivers/clk/tegra/clk-tegra210.c         | 1 +
>  include/dt-bindings/clock/tegra210-car.h | 2 +-
>  4 files changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160202/7edb760a/attachment.sig>
