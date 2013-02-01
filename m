From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 1 Feb 2013 11:14:55 +0530
Subject: [PATCH v3 08/15] ARM: introduce common set_auxcr/get_auxcr
 functions
In-Reply-To: <1359445870-18925-9-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-9-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <510B5657.8050707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013 01:21 PM, Nicolas Pitre wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Move the private set_auxcr/get_auxcr functions from
> drivers/cpuidle/cpuidle-calxeda.c so they can be used across platforms.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
