From: thierry.reding@gmail.com (Thierry Reding)
Date: Sat, 26 Apr 2014 00:11:15 +0200
Subject: [PATCH] ARM: tegra: use correct audio CODEC on Jetson TK1
In-Reply-To: <1398443012-17212-1-git-send-email-swarren@wwwdotorg.org>
References: <1398443012-17212-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140425221114.GA1352@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 10:23:32AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Jetson TK1 contains an RT5639 not an RT5640. While the two are extremely
> similar and mostly compatible, we should still use the correct device
> name in the device tree. I had meant to fix this before applying the
> initial DT, but this issue slipped my mind.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140426/d8cb5e3b/attachment.sig>
