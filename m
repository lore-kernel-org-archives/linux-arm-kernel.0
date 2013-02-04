From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 4 Feb 2013 18:31:08 +0100
Subject: [PATCH 1/2] ARM: tegra: Fix build error for gic update
In-Reply-To: <510FE95B.20207@wwwdotorg.org>
References: <1359976100-28871-1-git-send-email-hdoyu@nvidia.com><510FE95B.20207@wwwdotorg.org>
Message-ID: <20130204.193108.1174796447728622419.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> wrote @ Mon, 4 Feb 2013 18:01:15 +0100:

> On 02/04/2013 04:08 AM, Hiroshi Doyu wrote:
> > Fix build error in board-dt-tegra114.c(next-20130204)
> 
> Hiroshi, which tree should this patch be applied to? I assume it needs
> to go through arm-soc since that's where the Tegra and GIC patches meet?

"arm-soc" would be the place. Can you take care of this?
