From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 3 Dec 2013 14:40:05 -0800
Subject: [PATCH REPOST] dma: tegra: use reset framework
In-Reply-To: <1386102717-21773-1-git-send-email-swarren@wwwdotorg.org>
References: <1386102717-21773-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAPcyv4i1=HAok76pwmjpVDcRF==SrD-b6bRpFk3XZ3wPAuKGrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 3, 2013 at 12:31 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> Tegra's clock driver now provides an implementation of the common
> reset API (include/linux/reset.h). Use this instead of the old Tegra-
> specific API; that will soon be removed.
>
> Cc: pdeschrijver at nvidia.com
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> ---

Acked-by: Dan Williams <dan.j.williams@intel.com>
