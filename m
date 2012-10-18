From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Oct 2012 14:26:40 -0600
Subject: [PATCH] ARM: tegra: cpuidle: replace LP3 with
 ARM_CPUIDLE_WFI_STATE
In-Reply-To: <1349691856-30590-1-git-send-email-josephl@nvidia.com>
References: <1349691856-30590-1-git-send-email-josephl@nvidia.com>
Message-ID: <50806600.4000803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2012 04:24 AM, Joseph Lo wrote:
> The Tegra CPU idle LP3 state is doing ARM WFI only. So it's same with
> the common ARM_CPUIDLE_WFI_STATE. Using it to replace LP3 now.

Applied to Tegra's for-3.8/cpuidle branch (I created that branch in
anticipation of there being a bunch of other cpuidle work for 3.8).
