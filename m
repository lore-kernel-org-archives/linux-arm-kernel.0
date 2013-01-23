From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 23 Jan 2013 07:04:57 +0100
Subject: [v3 2/2] ARM: tegra: Skip scu_enable(scu_base) if not Cortex A9
In-Reply-To: <50FEC503.2080602@wwwdotorg.org>
References: <1358833924-24535-2-git-send-email-hdoyu@nvidia.com><50FE2CA8.20100@ti.com><50FEC503.2080602@wwwdotorg.org>
Message-ID: <20130123.080457.171573168772211248.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> wrote @ Tue, 22 Jan 2013 17:57:39 +0100:

> Hiroshi, is this series the only dependency you need for your
> Tegra114

Basically yes.

> series? So, I could merge your Tegra114 series once this series is applied?

But now "CCF" seems to be in. Then, the HACK(*1) needs to be replaced
with "Tegra114 CCF". But "Tegra114 CCF" doesn't seem ready yet. I'll check
if this Tegra114 series would work without "Tegra114 CCF".

*1: http://patchwork.ozlabs.org/patch/212010/
