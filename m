From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Jun 2013 10:30:16 -0600
Subject: [PATCH] clk: tegra: fix pllre initilization
In-Reply-To: <1370442111-13215-1-git-send-email-pdeschrijver@nvidia.com>
References: <1370442111-13215-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <51AF6798.30800@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2013 08:21 AM, Peter De Schrijver wrote:
> The PLLRE flags weren't set correctly. Fixed in this patch.

Tested-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
