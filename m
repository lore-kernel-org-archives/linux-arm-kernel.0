From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 9 Jan 2015 11:46:33 +0100
Subject: [PATCH] ARM: tegra: Fix unit address for Cortex-A9 TWD timer
In-Reply-To: <1420719873-9820-1-git-send-email-thierry.reding@gmail.com>
References: <1420719873-9820-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <20150109104632.GH27845@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 01:24:33PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The Cortex-A9 TWD timer has registers at address 0x50040600, but the
> unit address was 50004600, most likely a typo.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra20.dtsi | 2 +-
>  arch/arm/boot/dts/tegra30.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I've applied this to the for-3.20/dt branch.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150109/8c3d4a2f/attachment.sig>
