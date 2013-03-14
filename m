From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 14 Mar 2013 09:28:36 +0800
Subject: [PATCH V3 0/9] ARM: tegra: add platform suspend support
In-Reply-To: <5140B996.40400@wwwdotorg.org>
References: <1363161683-20825-1-git-send-email-josephl@nvidia.com>
 <5140B996.40400@wwwdotorg.org>
Message-ID: <1363224516.3308.10.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-03-14 at 01:38 +0800, Stephen Warren wrote:
> On 03/13/2013 02:01 AM, Joseph Lo wrote:
> > This series introduces a basic functionality for Tegra to support the
> > platform suspend and resume.
> > 
> > Note: This series only adds the support for Tegra20 and Tegra30. The
> > Tegra114 will be supported later.
> > 
> > This series were depending on the patch below that not yet be merged into
> > linux-mmc tree.
> > "mmc: tegra: use mmc_of_parse to get the support of standard MMC DT bindings"
> 
> Is that a compile-time dependency, or a run-time dependency? I assume
> this is simply a run-time dependency, and is also only a dependency for
> suspend itself to work; there wouldn't be any other regressions due to
> ignoring that dependency?
Exactly.

> In other words, if I simply apply this series without "mmc: tegra: use
> mmc_of_parse to get the support of standard MMC DT bindings", then the
> only issue is that suspend, a new feature, won't work correctly yet? If
> so, I believe I will ignore that dependency. The new feature will work
> in linux-next and 3.10-rc1.
OK.

Thanks,
Joseph
