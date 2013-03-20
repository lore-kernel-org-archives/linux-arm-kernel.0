From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 20 Mar 2013 18:15:09 +0800
Subject: [PATCH V4 0/9] ARM: tegra: add platform suspend support
In-Reply-To: <5148977F.7000700@wwwdotorg.org>
References: <1363594400-11663-1-git-send-email-josephl@nvidia.com>
 <5148977F.7000700@wwwdotorg.org>
Message-ID: <1363774509.5697.21.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-20 at 00:51 +0800, Stephen Warren wrote:
> On 03/18/2013 02:13 AM, Joseph Lo wrote:
> > This series introduces a basic functionality for Tegra to support the
> > platform suspend and resume.
> > 
> > Note: This series only adds the support for Tegra20 and Tegra30. The
> > Tegra114 will be supported later.
> > 
> > This series needs the patch below that not yet be merged into linux-mmc tree
> > to make the system suspend/resume function work correctly.
> > "mmc: tegra: use mmc_of_parse to get the support of standard MMC DT bindings"
> 
> I assume this series needs to be applied after the 3-long series you
> posted just before it, containing "ARM: dts: tegra: add clock source for
> PMC", "ARM: tegra: get PMC clock source from DT", and "ARM: tegra:
> moving the CPU power timer function to PMC driver"?

Oops, I mentioned this in the cover letter there and forgot to add here.
Yes, thanks for taking care.
