From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Oct 2013 12:59:47 -0600
Subject: [PATCH v3 05/19] clk: tegra: move some PLLC and PLLXC init to
 clk-pll.c
In-Reply-To: <1381848794-11761-6-git-send-email-pdeschrijver@nvidia.com>
References: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
 <1381848794-11761-6-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <525D90A3.2040606@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2013 08:52 AM, Peter De Schrijver wrote:
> vco min clipping, dynamic ramp setup and IDDQ init can be done in the
> respective pll clk_register functions if the parent is already registered.
> This is done for other some PLLs already.

Nit: VCO and PLL should be capitalized in this commit description. Same
with HW in the next patch.
