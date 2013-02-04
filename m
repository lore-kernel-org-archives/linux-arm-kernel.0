From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 04 Feb 2013 10:01:15 -0700
Subject: [PATCH 1/2] ARM: tegra: Fix build error for gic update
In-Reply-To: <1359976100-28871-1-git-send-email-hdoyu@nvidia.com>
References: <1359976100-28871-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <510FE95B.20207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2013 04:08 AM, Hiroshi Doyu wrote:
> Fix build error in board-dt-tegra114.c(next-20130204)

Hiroshi, which tree should this patch be applied to? I assume it needs
to go through arm-soc since that's where the Tegra and GIC patches meet?
