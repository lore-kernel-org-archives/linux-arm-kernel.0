From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Dec 2013 12:57:24 -0700
Subject: [PATCH v11 0/7] ARM: support for the Trusted Foundations secure
 monitor
In-Reply-To: <1385274652-16415-1-git-send-email-acourbot@nvidia.com>
References: <1385274652-16415-1-git-send-email-acourbot@nvidia.com>
Message-ID: <52AB66A4.9080209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2013 11:30 PM, Alexandre Courbot wrote:
> New rebase that should be ready-to-apply on the latest Tegra tree. The last
> remaining blocker is Russell's approval for this series and it is my hope to
> obtain it with this version.
> 
> There has been quite some debate around this series, notably about the SMC
> calling conventions and whether the firmware interface should be moved out of
> arch/arm. I hope that all the questions have been answered and that we can move
> forward with this series that enables NVIDIA-branded retail Tegra devices to run
> mainline.

I have applied this series to Tegra's for-3.14/trusted-foundations
branch. This is based directly on v3.13-rc1, so that if anyone needs to
merge patch 1 anywhere else to resolve conflicts, it'll be easy. I can
create a signed tag for that purpose if required.
