From: jagarwal@nvidia.com (Jay Agarwal)
Date: Fri, 12 Apr 2013 22:36:12 +0530
Subject: [PATCH 1/3] ARM: tegra: pcie: Add tegra3 support
In-Reply-To: <51683E00.4020506@wwwdotorg.org>
References: <1365435688-4179-1-git-send-email-jagarwal@nvidia.com>
 <51630ABB.1020200@wwwdotorg.org>
 <C79B248886DD134989C8FF6B096A91AB91B36FB300@BGMAIL01.nvidia.com>
 <51683E00.4020506@wwwdotorg.org>
Message-ID: <C79B248886DD134989C8FF6B096A91AB91B36FB302@BGMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 04/12/2013 10:43 AM, Jay Agarwal wrote:
> >> On 04/08/2013 09:41 AM, Jay Agarwal wrote:
> >>> Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
> >>>
> >>> - Enable pcie root port 2 for cardhu
> >>> - Make private data structure for each SOC
> >>> - Add required tegra3 clocks and regulators
> >>> - Add tegra3 specific code in enable controller
> >>> - Modify clock tree to get clocks based on device
> >>> - Based on git://gitorious.org/thierryreding/linux.git
> >>
> >> A couple more points on this patch:
> >>
> >> * You didn't mention that this series is based on Thierry's
> >> work-in-progress tree, and not something immediately destined for
> >> upstream. As such, only Thierry is expected to actually apply any of these
> patches.
> >>
> > [>] Stephen, I have mentioned it in comment description as Based on
> git://gitorious.org/thierryreding/linux.git, is this not enough?
> 
> Well, first off, there are many branches there, and secondly the branch that
> a series is based on doesn't necessarily imply much about what you expect
> people to do with it.
> 
I am not clear, What should I mention then?
