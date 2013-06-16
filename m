From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 16 Jun 2013 11:51:33 -0700
Subject: [PATCH V4 1/4] ARM: tegra30: clocks: Fix pciex clock registration
In-Reply-To: <51B8956B.8020704@wwwdotorg.org>
References: <1371021223-6709-1-git-send-email-jagarwal@nvidia.com>
 <51B8956B.8020704@wwwdotorg.org>
Message-ID: <20130616185132.7541.680@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2013-06-12 08:36:11)
> On 06/12/2013 01:13 AM, Jay Agarwal wrote:
> > Registering pciex as peripheral clock instead of fixed clock
> > as tegra_perih_reset_assert(deassert) api of this clock api
> > gives warning and ultimately does not succeed to assert(deassert)
> > 
> > Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
> > ---
> > Patch is based on remotes/gitorious_thierryreding_linux/tegra/next and should be applied on top of this.
> 
> In this case, it would make more sense to apply this to the clock tree,
> since it's a standalone bug-fix.
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>

Pulled into clk-fixes for -rc7.

Regards,
Mike
