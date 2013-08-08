From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Aug 2013 12:16:55 -0600
Subject: [PATCH 1/3] clk: tegra114: Fix incorrect placement of __initdata
In-Reply-To: <1375935949-19557-1-git-send-email-sachin.kamat@linaro.org>
References: <1375935949-19557-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <5203E097.1040502@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2013 10:25 PM, Sachin Kamat wrote:
> __initdata should be placed between the variable name and equal
> sign for the variable to be placed in the intended section.

The series,
Acked-by: Stephen Warren <swarren@nvidia.com>

Patch 1,
Tested-by: Stephen Warren <swarren@nvidia.com>

Mike, I assume you'll take these through the clock tree.
