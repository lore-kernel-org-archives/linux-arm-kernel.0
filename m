From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Dec 2013 10:35:21 -0700
Subject: pull request for clk-tegra-next
In-Reply-To: <20131128141826.GW26617@tbergstrom-lnx.Nvidia.com>
References: <20131128141826.GW26617@tbergstrom-lnx.Nvidia.com>
Message-ID: <529E1659.2070103@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28/2013 07:18 AM, Peter De Schrijver wrote:
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> 
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> 
> are available in the git repository at:
>   git://nv-tegra.nvidia.com/user/pdeschrijver/linux.git clk-tegra-next

Mike, this series is a dependency for my patch series that converts
Tegra drivers to use the standard module reset API rather than a custom
API (which is implemented in the clock driver). If you could either
merge this pull request, or at least ack that it's OK for me to merge it
into the Tegra tree as a dependency, that'd be helpful. Thanks.
