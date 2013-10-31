From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 31 Oct 2013 13:02:26 -0600
Subject: [PATCH] clk: fix boot panic with non-dev-associated clocks
In-Reply-To: <1383238174-14650-1-git-send-email-olof@lixom.net>
References: <1383238174-14650-1-git-send-email-olof@lixom.net>
Message-ID: <5272A942.8010604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2013 10:49 AM, Olof Johansson wrote:
> Fixes a panic at boot on many platforms. For example, on imx (wandboard),
> I get:
...
> Fixes: 7c042b5e39c9 ('clk: Allow drivers to pass in a regmap')
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Olof Johansson <olof@lixom.net>

Tested-by: Stephen Warren <swarren@nvidia.com>
