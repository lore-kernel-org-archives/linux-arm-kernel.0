From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 17 Jun 2014 16:23:17 +0300
Subject: [PATCH] misc: fuse: fix dummy functions
In-Reply-To: <1402953115-32489-1-git-send-email-swarren@wwwdotorg.org>
References: <1402953115-32489-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140617132317.GG3407@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 11:11:55PM +0200, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The Tegra fuse header's dummy functions for the case where Tegra20 is
> disabled are inconsistent with the correct prototypes, and have some
> syntax errors. Fix these. While at it, fix the indentation level of
> the dummy function bodies.
> 
> Fixes: 40969e30ad7c ("misc: fuse: Add efuse driver for Tegra")
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> I intend to immediately apply this to Tegra's for-3.17/fuse-move branch.
> ---

Acked-by:  Peter De Schrijver <pdeschrijver@nvidia.com>
