From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Jun 2014 15:21:57 -0600
Subject: [PATCH v2 3/3] ARM: tegra: Initialize flow controller from DT
In-Reply-To: <1403870848-1754-3-git-send-email-thierry.reding@gmail.com>
References: <1403870848-1754-1-git-send-email-thierry.reding@gmail.com>
 <1403870848-1754-3-git-send-email-thierry.reding@gmail.com>
Message-ID: <53ADE075.4090308@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 06:07 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Use a matching device tree node to initialize the flow controller driver
> instead of hard-coding the I/O address. This is necessary to get rid of
> the iomap.h include, which in turn make it easier to share this code
> with 64-bit Tegra SoCs.

This patch,
Acked-by: Stephen Warren <swarren@nvidia.com>
