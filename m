From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Jun 2014 15:20:52 -0600
Subject: [PATCH v2 2/3] ARM: tegra: Add device tree nodes for flow
 controller
In-Reply-To: <1403870848-1754-2-git-send-email-thierry.reding@gmail.com>
References: <1403870848-1754-1-git-send-email-thierry.reding@gmail.com>
 <1403870848-1754-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <53ADE034.70307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 06:07 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> These nodes are required so that the flow controller driver can obtain
> the I/O memory region from device tree rather than hard-coding it.

This patch,
Acked-by: Stephen Warren <swarren@nvidia.com>
