From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 04 Feb 2013 14:57:17 -0700
Subject: [PATCH v5 01/10] clk: tegra: Refactor PLL programming code
In-Reply-To: <1359713962-16822-2-git-send-email-pdeschrijver@nvidia.com>
References: <1359713962-16822-1-git-send-email-pdeschrijver@nvidia.com>
 <1359713962-16822-2-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <51102EBD.1060507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2013 03:18 AM, Peter De Schrijver wrote:
> Refactor the PLL programming code to make it useable by the new PLL types
> introduced by Tegra114.

I tested this series on Tegra20 and Tegra30 for regressions and found
none. Note that I didn't test on Tegra114. The series,

Tested-by: Stephen Warren <swarren@nvidia.com>

Also, I briefly reviewed the code and aside from comments that have
already been made, so the series,

Reviewed-by: Stephen Warren <swarren@nvidia.com>
