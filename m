From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 14 Feb 2013 21:34:22 +0100
Subject: [v2 1/4] ARM: tegra20: create a DT header defining CLK IDs
In-Reply-To: <511D45E0.1080105@wwwdotorg.org>
References: <1360868369-20093-1-git-send-email-hdoyu@nvidia.com><1360868369-20093-2-git-send-email-hdoyu@nvidia.com><511D45E0.1080105@wwwdotorg.org>
Message-ID: <20130214.223422.1106350409475384652.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> wrote @ Thu, 14 Feb 2013 21:15:28 +0100:

> Oh, and I don't think you updated e.g. nvidia,tegra20-car.txt to remove
> the list of clocks.

Not yet removed. I think that this could be done with the patch which
allows kernel source to include DT header files.

> BTW, I assume this patch includes the changes from my recent "clk:
> tegra: fix driver to match DT binding" and anything else similar that's
> in the most recent Tegra for-next?

Of course not, that's a little bit too recent.

I'll rerun my script against the laste Tegra for-next and post them as
v3(inc. Tegra114)
