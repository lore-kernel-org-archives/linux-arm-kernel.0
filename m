From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Jun 2013 10:22:32 -0600
Subject: [PATCH] clk: tegra: pllp_out2 divider is int only
In-Reply-To: <1370439442-30852-1-git-send-email-pdeschrijver@nvidia.com>
References: <1370439442-30852-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <51AF65C8.3030702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2013 07:37 AM, Peter De Schrijver wrote:
> The pllp_out2 should be integer only, the fractional bit should always be 0.

Tested-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
