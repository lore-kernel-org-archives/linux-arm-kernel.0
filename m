From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 22 Jan 2013 11:37:36 +0530
Subject: [v3 2/2] ARM: tegra: Skip scu_enable(scu_base) if not Cortex
 A9
In-Reply-To: <1358833924-24535-2-git-send-email-hdoyu@nvidia.com>
References: <1358833924-24535-1-git-send-email-hdoyu@nvidia.com>
 <1358833924-24535-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <50FE2CA8.20100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 January 2013 11:22 AM, Hiroshi Doyu wrote:
> Skip scu_enable(scu_base) if CPU is not Cortex A9 with SCU.
>
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
Looks fine. I will also update OMAP code with the new
interface. Thanks.

For the patch,
Acked-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
