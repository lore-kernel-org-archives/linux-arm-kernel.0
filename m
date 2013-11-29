From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 15:55:47 +0100
Subject: [PATCH 30/31] clk: tegra: remove legacy reset APIs
In-Reply-To: <1384548866-13141-31-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-31-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131129145546.GJ9712@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:54:25PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Now that no code uses the custom Tegra module reset API, we can remove
> its implementation.
> 
> Cc: treding at nvidia.com
> Cc: pdeschrijver at nvidia.com
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.
> ---
>  drivers/clk/tegra/clk-periph-gate.c | 22 --------------------
>  drivers/clk/tegra/clk-periph.c      | 40 -------------------------------------
>  drivers/clk/tegra/clk.h             |  1 -
>  include/linux/clk/tegra.h           |  7 -------
>  4 files changed, 70 deletions(-)

Very nice!

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/4ec29560/attachment.sig>
