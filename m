From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 25 Oct 2018 16:40:54 +0200
Subject: [PATCH 1/2] arm64: tegra: Add PWM controllers on Tegra194
In-Reply-To: <20181024153353.15745-1-thierry.reding@gmail.com>
References: <20181024153353.15745-1-thierry.reding@gmail.com>
Message-ID: <20181025144054.GM21521@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2018 at 05:33:52PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Tegra194 has eight single-channel PWM controllers, one of them in the
> AON partition.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 96 ++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)

Both patches applied to for-4.21/arm64/dt.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181025/91cefa3e/attachment.sig>
