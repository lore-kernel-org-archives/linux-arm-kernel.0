From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 22 Nov 2013 15:40:35 +0200
Subject: [PATCH] clk: tegra: use pll_ref as the pll_e parent
In-Reply-To: <1383093707-10312-1-git-send-email-pdeschrijver@nvidia.com>
References: <1383093707-10312-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20131122134035.GD26617@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 01:41:29AM +0100, Peter De Schrijver wrote:
> Use pll_ref instead of pll_re_vco as the pll_e parent on Tegra114 and
> Tegra124. Also add a pll_ref table entry for pll_e for Tegra114.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

I will squash this into the next tegra-clk-next as the previous pull request
has never made it.

Cheers,

Peter.
