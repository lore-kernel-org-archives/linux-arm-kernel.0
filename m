From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Sep 2013 12:38:31 -0600
Subject: [PATCH 12/12] clk: tegra: introduce common gen4 super clock
In-Reply-To: <1379515331-19427-13-git-send-email-pdeschrijver@nvidia.com>
References: <1379515331-19427-1-git-send-email-pdeschrijver@nvidia.com>
 <1379515331-19427-13-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <52408AA7.7080003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 08:41 AM, Peter De Schrijver wrote:
> Introduce a common function which super clock initialization for Tegra114
> and beyond.

Again, I'm sure that a lot of the data tables in this patch are actually
SoC-specific, unless we expect Tegra114's pll_x (CPU PLL) to define the
max CPU frequency on all future SoCs...
