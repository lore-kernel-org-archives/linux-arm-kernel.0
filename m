From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Dec 2013 16:22:26 +0100
Subject: [PATCH 1/2] ARM: tegra: rebuild tegra_defconfig
In-Reply-To: <1386196073-25193-1-git-send-email-swarren@wwwdotorg.org>
References: <1386196073-25193-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131206152225.GF32372@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 03:27:52PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This separates out "NULL" changes from future real changes.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/configs/tegra_defconfig | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Not sure if this makes sense for what's essentially a machine-generated
change, but I've at least verified that this doesn't drop anything
unwanted, so:

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/3c5ec8aa/attachment.sig>
