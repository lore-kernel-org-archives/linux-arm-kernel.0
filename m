From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Jun 2013 11:44:24 -0600
Subject: [PATCH] ARM: tegra: remove the ifdef of ARCH SoC in the
 tegra_resume
In-Reply-To: <1370247004-31846-1-git-send-email-josephl@nvidia.com>
References: <1370247004-31846-1-git-send-email-josephl@nvidia.com>
Message-ID: <51AF78F8.8040609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2013 02:10 AM, Joseph Lo wrote:
> Removing the ifdef of ARCH_TEGRA_SoC in the tegra_resume function. Because
> we always build with all Tegra SoCs support and had a runtime chip
> detection code there. And we expect most of the chips would need the code
> in the future.
> 
> We also fix a typo of a macro name that cause a build error.

Applied to Tegra's for-3.11/soc, with re-written commit description.
