From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Oct 2013 13:37:23 -0600
Subject: [PATCH v3 13/19] clk: tegra: introduce common gen4 super clock
In-Reply-To: <1381848794-11761-14-git-send-email-pdeschrijver@nvidia.com>
References: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
 <1381848794-11761-14-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <525D9973.2070501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2013 08:52 AM, Peter De Schrijver wrote:
> Introduce a common function which super clock initialization for Tegra114
> and beyond.

Nit: s/which/{which,that} performs/ ?

For my education, why are cclk_g, cclk_lp, pll_x related to the super
clock? I thought sclk/hclk/pclk were bus clocks, not something related
to the CPU clock(s).
