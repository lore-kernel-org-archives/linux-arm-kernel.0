From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 14 May 2013 07:59:40 +0200
Subject: [PATCH 1/6] ARM: tegra20: create a DT header defining CLK IDs
In-Reply-To: <519118E3.4060907@wwwdotorg.org>
References: <1368443225-16978-1-git-send-email-hdoyu@nvidia.com><1368443225-16978-2-git-send-email-hdoyu@nvidia.com><519118E3.4060907@wwwdotorg.org>
Message-ID: <20130514.085940.1807211932170883314.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> wrote @ Mon, 13 May 2013 18:46:27 +0200:

> I'm not sure exactly how these patches will get merged. For you
> reference, I anticipate one of two things happening:
> 
> 1)
> 
> * Patches 1, 3, 5 get put into a topic branch, and merged into both the
> clk tree and the Tegra tree.
> 
> * Patches 2, 4, 6 get merged into the Tegra tree.
> 
> * The patches you're going to create for the drivers/clk code get merged
> into Mike's clk tree
> 
> 2)
> 
> * Mike ack's the patches you're going to create for the drivers/clk code.
> 
> * Everything gets merged through the Tegra tree.
> 
> This shouldn't impact you much, but just be aware that the drivers/clk
> changes you create shouldn't depend on anything beyond patches 1, 3, 5
> here and 3.10-rc1, then I can work out the merging with Mike without any
> constraints.

Either way would work. Once Venu's USB patches are merged, mentioned
in [2/6], I'll resend the update version of this series.
drivers/clk/tegra replacement will follow, then.
