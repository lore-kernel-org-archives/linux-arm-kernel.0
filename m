From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 3 Oct 2013 12:16:36 +0300
Subject: [PATCH v2 00/12] Introduce common infra for tegra clocks
In-Reply-To: <524B08BD.2020902@wwwdotorg.org>
References: <1379946381-20125-1-git-send-email-pdeschrijver@nvidia.com>
 <524B08BD.2020902@wwwdotorg.org>
Message-ID: <20131003091636.GJ3973@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 07:39:09PM +0200, Stephen Warren wrote:
> On 09/23/2013 08:24 AM, Peter De Schrijver wrote:
> > This patchset introduces common infrastructure for clocks which exist in
> > several Tegra SoCs. We also move Tegra114 to this new infrastructure.
> > Tegra20 and Tegra30 will be moved later in separate patchsets.
> > 
> > Changes since v1:
> > + move common clks allocation to patch 2
> > + adapt also Tegra20 and Tegra30 to the changes in patch 2
> > 
> > Boottested on dalmore, beaverboard and seaboard.
> 
> What commit is this series based on? I applied the two pre-requisites:
> 

9f186fbe58c749e2d4c0b334818705aa622fc76b Add linux-next specific files for 20130822

Cheers,

Peter.
