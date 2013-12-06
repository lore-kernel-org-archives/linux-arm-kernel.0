From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Dec 2013 16:23:18 +0100
Subject: [PATCH 2/2] ARM: tegra: enable MAX98090 audio driver in
 tegra_defconfig
In-Reply-To: <1386196073-25193-2-git-send-email-swarren@wwwdotorg.org>
References: <1386196073-25193-1-git-send-email-swarren@wwwdotorg.org>
 <1386196073-25193-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131206152317.GG32372@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 03:27:53PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This audio driver is required by the Venice2 board.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/configs/tegra_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/6a52e593/attachment-0001.sig>
