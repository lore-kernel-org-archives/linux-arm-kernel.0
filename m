From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 28 May 2013 09:16:14 -0600
Subject: [PATCH] clk: tegra: fix clk_out parents list
In-Reply-To: <1369641279-6894-1-git-send-email-pgaikwad@nvidia.com>
References: <1369641279-6894-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <51A4CA3E.9080608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2013 01:54 AM, Prashant Gaikwad wrote:
> Number of parents for clk_out_2 and clk_out_3 was incorrectly set
> to clk_out1_parents. Even though it did not break anything since the
> size was same better to fix.

Acked-by: Stephen Warren <swarren@nvidia.com>
