From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 2 Oct 2012 22:03:11 +0200
Subject: [PATCH 1/2] ARM: tegra: fix invalid unit-address in tegra*.dtsi
In-Reply-To: <1349205048-22228-1-git-send-email-swarren@wwwdotorg.org>
References: <1349205048-22228-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121002200311.GB31363@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2012 at 01:10:47PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Unit addresses, whilst written in hex, don't contain a 0x prefix.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> A couple of small cleanups/tweaks for 3.7 if possible.
> 
>  arch/arm/boot/dts/tegra20-seaboard.dts |    2 +-
>  arch/arm/boot/dts/tegra20.dtsi         |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Both patches,

Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121002/5290df07/attachment.sig>
