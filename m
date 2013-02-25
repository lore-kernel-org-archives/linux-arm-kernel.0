From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Feb 2013 13:56:53 -0700
Subject: [PATCH V4 2/2] MAINTAINERS: update Tegra section to capture all
 Tegra files
In-Reply-To: <1360629574-23989-2-git-send-email-swarren@wwwdotorg.org>
References: <1360629574-23989-1-git-send-email-swarren@wwwdotorg.org>
 <1360629574-23989-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <512BD015.5000200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2013 05:39 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The intent is to ensure that all Tegra-related patches are sent to the
> linux-tegra@ mailing list, so people can keep up-to-date on all misc
> driver changes.
> 
> Doing this with a keyword is far simpler and more compact than listing
> all Tegra-related drivers, even if wildcards were used.
> 
> Words such as integrate or integrator are common. Ensure the character
> right before "tegra" isn't a-z (case-insensitive), to make sure the
> keyword doesn't match those.
> 
> The only files that the keyword doesn't match are the NVEC driver. Add
> the linux-tegra mailing list to the NVEC entry to solve this.

Andrew, I see you've taken patch 1/2 into your tree. Are you planning on
taking patch 2/2 as well? Patch 2/2 depends on patch 1/2, so they really
should go through the same tree, or into different kernel versions or -rcs.

Thanks.
