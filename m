From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 13 Jun 2017 16:52:07 +0200
Subject: [PATCH 11/15] arm64: dts: nvidia: fix PCI bus dtc warnings
In-Reply-To: <20170322020313.24338-11-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
 <20170322020313.24338-11-robh@kernel.org>
Message-ID: <20170613145207.GC20577@ulmo.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 09:03:09PM -0500, Rob Herring wrote:
> dtc recently added PCI bus checks. Fix these warnings.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: linux-tegra at vger.kernel.org
> ---
> Sub-arch maintainers, please apply to your trees unless arm-soc wants 
> to take the whole lot.
> 
>  arch/arm64/boot/dts/nvidia/tegra132.dtsi           | 4 +++-
>  arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 2 +-
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 4 +++-
>  3 files changed, 7 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170613/c368debb/attachment.sig>
