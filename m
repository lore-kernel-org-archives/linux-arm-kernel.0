From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Aug 2013 09:38:33 -0600
Subject: [PATCH v2] clk: tegra: Correct sbc mux width & parent
In-Reply-To: <1375941327-4231-1-git-send-email-markz@nvidia.com>
References: <1375941327-4231-1-git-send-email-markz@nvidia.com>
Message-ID: <5203BB79.1000704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2013 11:55 PM, Mark Zhang wrote:
> Tegra114 sbc1-sbc6 have more possible parent clocks than Tegra30.
> So correct the parents and mux width for them.

Acked-by: Stephen Warren <swarren@nvidia.com>

(although it'd be nice for Peter or Prashant to double check it)
