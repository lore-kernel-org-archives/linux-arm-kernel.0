From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 3 Jan 2013 07:38:48 +0100
Subject: [PATCH 4/4] ARM: tegra: Set SCU base address dynamically from DT
In-Reply-To: <50E4845D.6020809@wwwdotorg.org>
References: <1355725087-11363-1-git-send-email-hdoyu@nvidia.com><1355725087-11363-4-git-send-email-hdoyu@nvidia.com><50E4845D.6020809@wwwdotorg.org>
Message-ID: <20130103.083848.1533296860718294309.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> wrote @ Wed, 2 Jan 2013 20:02:53 +0100:

> On 12/16/2012 11:18 PM, Hiroshi Doyu wrote:
> > Set Snoop Control Unit(SCU) register base address dynamically from DT.
> 
> Hiroshi, what's the status on this patch series? I think Rob had
> comments/objections on patch 4; are you going to post an updated series,
> or is this series replaced by patch 3 in your Tegra114 series?

As Rob suggested, at least, SCU base address should be detected in
common code, scu_of_init() even if DT /cpus is the primary way to
detect # of cores. I'll repost later.

This patch can be done independent of Tegra114 series.
