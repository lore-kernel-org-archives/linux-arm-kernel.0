From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Jun 2013 10:22:02 -0600
Subject: [PATCH] clk: tegra: pllc and pllxc should use pdiv_map
In-Reply-To: <1370437007-25596-1-git-send-email-pdeschrijver@nvidia.com>
References: <1370437007-25596-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <51AF65AA.2000702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2013 06:56 AM, Peter De Schrijver wrote:
> The pllc and pllxc code weren't always using the correct pdiv_map to
> map between the post divider value and the hw p field. This could result
> in illegal values being programmed in the hw.

Tested-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
